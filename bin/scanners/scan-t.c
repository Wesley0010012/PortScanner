#include <stdio.h>
#include <netdb.h>

int main()
{
	int port;
	port = target_port;
	int s,c;
	struct sockaddr_in target;

	s = socket(AF_INET, SOCK_STREAM, 0);
	target.sin_family = AF_INET;
	target.sin_port = htons(port);
	target.sin_addr.s_addr = inet_addr("ip_target");

	c = connect(s, (struct sockaddr *)&target, sizeof target);
	if(c == 0)
	{
		printf("Port %d: OPEN\n", port);
		close(s);
		close(c);
	}
	else
	{

	}
}
