#include <stdio.h>
#include <netdb.h>

int main()
{
	int start, end;

	start = 1;
	end = 65535;

	for(int i = start; i<= end; i++)
	{
		int s,c;
		struct sockaddr_in target;

		s = socket(AF_INET, SOCK_STREAM, 0);
		target.sin_family = AF_INET;
		target.sin_port = htons(i);
		target.sin_addr.s_addr = inet_addr("ip_target");

		c = connect(s, (struct sockaddr *)&target, sizeof target);
		if(c == 0)
		{
			printf("Port %d: OPEN\n", i);
			close(s);
			close(c);
		}
		else
		{

		}
	}
}
