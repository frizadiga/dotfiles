#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

int main() {
	struct timespec ts;
	struct tm *tm_info;
	char datetime[20];

	clock_gettime(CLOCK_REALTIME, &ts);
	tm_info = localtime(&ts.tv_sec);

	strftime(datetime, sizeof(datetime), "%a.%d.%m %H:%M", tm_info);
	for (int i = 0; datetime[i]; i++)
		datetime[i] = tolower(datetime[i]);

	// get battery level (simplified command)
	FILE *fp = popen("pmset -g batt | grep -o '[0-9]*%' | head -1 | tr -d '%'", "r");
	char batt[8] = "?";
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
