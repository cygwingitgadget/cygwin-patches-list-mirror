Return-Path: <cygwin-patches-return-1486-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 3566 invoked by alias); 13 Nov 2001 13:09:19 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 3552 invoked from network); 13 Nov 2001 13:09:17 -0000
Message-ID: <911C684A29ACD311921800508B7293BA010A900F@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: patch to mkpasswd.c - allows selection of specific user
Date: Tue, 09 Oct 2001 10:20:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-SW-Source: 2001-q4/txt/msg00018.txt.bz2

Sorry.  I threw that in at the last.  Thought it might be helpful for the
enduser to get a little feedback for that error.  I'll fix it.

> -----Original Message-----
> From: Christopher Faylor [mailto:cgf@redhat.com] 
> Sent: Tuesday, November 13, 2001 12:22 AM
> To: cygwin-patches@cygwin.com
> Subject: Re: patch to mkpasswd.c - allows selection of specific user
> 
> 
> On Tue, Nov 13, 2001 at 04:02:32PM +1100, Mathew Boorman wrote:
> >Darn, now I'm told about Marks patch!
> >Anyway, onward...
> >
> >Mark Bradshaw:
> >
> >>@@ -135,6 +145,7 @@ enum_users (LPWSTR servername, int print
> >> 	default:
> >> 	  fprintf (stderr, "NetUserEnum() failed with %ld\n", rc);
> >>+	  if ( rc == 2221 ) printf("That user doesn't appear to 
> exist.\n");
> >
> >The appropriate error codes are in <lmerr.h> around, I noted 
> some were 
> >slightly different in name though. I believe this message 
> should go to 
> >stderr anyway, otherwise you would end up with a polluted 
> /etc/passwd 
> >file.
> 
> Oops.  This points out a couple of problems that I didn't 
> notice before.
> 
> 1) Never use a raw number like the above, as Mathew has said.
> 
> 2) This is not the correct format for an if statement.  You 
> aren't adhering
>    to the GNU formatting conventions.  Please use the 
> formatting of the
>    code that you are patching.  This is good advice for 
> whatever project
>    you are on.
> 
> Thanks,
> cgf
> 
