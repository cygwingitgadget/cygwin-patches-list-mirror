From: Mathew Boorman <mathew.boorman@au.cmg.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: patch to mkpasswd.c - allows selection of specific user
Date: Mon, 12 Nov 2001 21:04:00 -0000
Message-ID: <FB7B5F146C8CD5118E0D00306E005CDA02EA5F@AP-CAN-MAIL01>
X-SW-Source: 2001-q4/msg00211.html
Message-ID: <20011112210400.sKv8GdwmRMR2ed-Q6KKyhjUquWFYooypfm2fQS69yCg@z>

Darn, now I'm told about Marks patch!
Anyway, onward...

Mark Bradshaw:

>@@ -135,6 +145,7 @@ enum_users (LPWSTR servername, int print
> 	default:
> 	  fprintf (stderr, "NetUserEnum() failed with %ld\n", rc);
>+	  if ( rc == 2221 ) printf("That user doesn't appear to exist.\n");

The appropriate error codes are in <lmerr.h> around, I noted some were
slightly different in name though.
I believe this message should go to stderr anyway, otherwise you would end
up with a polluted /etc/passwd file.


m@
