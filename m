From: David Peterson <David.Peterson@mail.idrive.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: new option for ssh-agent.exe
Date: Thu, 15 Mar 2001 15:21:00 -0000
Message-id: <B1F282D5B226D411B8B900E08110486F01E85744@sweetness.idrive.com>
X-SW-Source: 2001-q1/msg00184.html

Hello,

I've added an option to ssh-agent to make it easier to use as a service on
Windows NT/2000. The code change isn't really windows-specific, but the
associated scripts are. I'm not sure if I should send the patch here or to
the OpenSSH maintainers.

The option keeps ssh-agent from exiting when parent process that it starts
exits. I have ssh-agent run a script that publishes the environment
variables using the setx command. That script exits right away, but
ssh-agent keeps running.

I've also written scripts to register both sshd and ssh-agent as NT
services. All the scripts are here and there is a "real" patch + changelog
at the end for the changes to ssh-agent.c.

The scripts depend on tools from the Windows NT/2000 resource kit - namely
setx, srvany, and instsrv.

-dave.

--------------- install-ssh-agent-service.sh ------------
#!/bin/sh -x

SRVANY_PATH=`type srvany.exe | awk '{print $3}'`
SRVANY_PATH=`cygpath -a -w "${SRVANY_PATH}"`

instsrv sshagent ${SRVANY_PATH}

SERVICE_BASE_KEY='\machine\SYSTEM\CurrentControlSet\Services\sshagent'

regtool -s set "${SERVICE_BASE_KEY}\DisplayName" "Secure Identity Agent
Service"
regtool -s set "${SERVICE_BASE_KEY}\Description" "Provides agent that
manages identities for the ssh program."


SSH_AGENT_PATH=`cygpath -a -w /usr/bin/ssh-agent.exe`
PUBLISH_SCRIPT_PATH="/usr/share/ssh-services/publish-agent.sh"

PARAMETERS_BASE_KEY="${SERVICE_BASE_KEY}\Parameters"

regtool add "${PARAMETERS_BASE_KEY}"
regtool -s set "${PARAMETERS_BASE_KEY}\Application" "${SSH_AGENT_PATH}"
regtool -s set "${PARAMETERS_BASE_KEY}\AppParameters" "-n
${PUBLISH_SCRIPT_PATH}"

---------------------- end -----------------------------
--------------- install-sshd-service.sh ----------------
#!/bin/sh -x

SRVANY_PATH=`type srvany.exe | awk '{print $3}'`
SRVANY_PATH=`cygpath -a -w "${SRVANY_PATH}"`

instsrv sshd ${SRVANY_PATH}

SERVICE_BASE_KEY='\machine\SYSTEM\CurrentControlSet\Services\sshd'

regtool -s set "${SERVICE_BASE_KEY}\DisplayName" "Secure Shell Service"
regtool -s set "${SERVICE_BASE_KEY}\Description" "Provides secure remote
logon using the ssh protocol."


SSHD_PATH=`cygpath -a -w /usr/sbin/sshd.exe`

PARAMETERS_BASE_KEY="${SERVICE_BASE_KEY}\Parameters"

regtool add "${PARAMETERS_BASE_KEY}"
regtool -s set "${PARAMETERS_BASE_KEY}\Application" "${SSHD_PATH}"

---------------- publish-agent.sh ----------------------
#!/bin/sh

setx SSH_AUTH_SOCK $SSH_AUTH_SOCK -m
setx SSH_AGENT_PID $SSH_AGENT_PID -m

---------------- end ------------------------------------
----------------- patch follows -------------------------

Thu Mar 25 15:00:00 2001 David Peterson <chief@mail.idrive.com>

	* ssh-agent.c: add "-n" option that causes the agent
	to not quit after the parent process exits.
	(main): look for flag, don't set alarm if set.

--- ../openssh-2.5.1p2/ssh-agent.c	Sat Feb 10 15:13:41 2001
+++ ssh-agent.c	Wed Mar 14 23:56:18 2001
@@ -708,7 +708,7 @@ void
 usage(void)
 {
 	fprintf(stderr, "ssh-agent version %s\n", SSH_VERSION);
-	fprintf(stderr, "Usage: %s [-c | -s] [-k] [command {args...]]\n",
+	fprintf(stderr, "Usage: %s [-c | -s] [-k] [ [-n] command
{args...]]\n",
 	    __progname);
 	exit(1);
 }
@@ -716,7 +716,7 @@ usage(void)
 int
 main(int ac, char **av)
 {
-	int sock, c_flag = 0, k_flag = 0, s_flag = 0, ch;
+	int sock, c_flag = 0, k_flag = 0, s_flag = 0, n_flag = 0, ch;
 	struct sockaddr_un sunaddr;
 #ifdef HAVE_SETRLIMIT
 	struct rlimit rlim;
@@ -730,9 +730,9 @@ main(int ac, char **av)
 	init_rng();
 
 #ifdef __GNU_LIBRARY__
-	while ((ch = getopt(ac, av, "+cks")) != -1) {
+	while ((ch = getopt(ac, av, "+cksn")) != -1) {
 #else /* __GNU_LIBRARY__ */
-	while ((ch = getopt(ac, av, "cks")) != -1) {
+	while ((ch = getopt(ac, av, "cksn")) != -1) {
 #endif /* __GNU_LIBRARY__ */
 		switch (ch) {
 		case 'c':
@@ -748,6 +748,9 @@ main(int ac, char **av)
 				usage();
 			s_flag++;
 			break;
+        case 'n':
+			n_flag++;
+			break;
 		default:
 			usage();
 		}
@@ -869,7 +872,7 @@ main(int ac, char **av)
 		cleanup_exit(1);
 	}
 	new_socket(AUTH_SOCKET, sock);
-	if (ac > 0) {
+	if ((ac > 0) && (!n_flag)) {
 		signal(SIGALRM, check_parent_exists);
 		alarm(10);
 	}
