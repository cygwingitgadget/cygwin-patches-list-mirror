Return-Path: <cygwin-patches-return-1483-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 23245 invoked by alias); 13 Nov 2001 05:04:05 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 23219 invoked from network); 13 Nov 2001 05:04:00 -0000
Message-ID: <FB7B5F146C8CD5118E0D00306E005CDA02EA5F@AP-CAN-MAIL01>
From: Mathew Boorman <mathew.boorman@au.cmg.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: patch to mkpasswd.c - allows selection of specific user
Date: Sun, 07 Oct 2001 05:22:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
X-SW-Source: 2001-q4/txt/msg00015.txt.bz2

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
