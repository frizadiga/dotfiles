#define _POSIX_C_SOURCE 200809L
#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <stdlib.h>

int main() {
	struct timespec ts;
	struct tm *tm_info;
	char datetime[20];
	clock_gettime(CLOCK_REALTIME, &ts);
	tm_info = localtime(&ts.tv_sec);
	strftime(datetime, sizeof(datetime), "%a.%d.%m %H:%M", tm_info);
	for (int i = 0; datetime[i]; i++)
		datetime[i] = tolower(datetime[i]);
	// get battery level (works on both Linux and macOS)
	char batt[8] = "?";
	#ifdef __APPLE__
		FILE *fp = popen("pmset -g batt | grep -o '[0-9]*%' | head -1 | tr -d '%'", "r");
	#else
		FILE *fp = popen("cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || cat /sys/class/power_supply/BAT1/capacity 2>/dev/null || echo '?'", "r");
	#endif
	
	if (fp) {
		if (fgets(batt, sizeof(batt), fp)) {
			batt[strcspn(batt, "\n")] = 0;
		}
		pclose(fp);
	}
	// using write() for direct output for performance
	char output[64];
	int len = snprintf(output, sizeof(output), "%s %s\n", datetime, batt);
	write(STDOUT_FILENO, output, len);
	return 0;
}
