Return-Path: <cygwin-patches-return-1736-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18391 invoked by alias); 18 Jan 2002 02:19:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18375 invoked from network); 18 Jan 2002 02:19:00 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2A64@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: strptime addition to cygwin
Date: Thu, 17 Jan 2002 18:19:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
X-SW-Source: 2002-q1/txt/msg00093.txt.bz2

Seems I need a little hand holding if someone can spare a moment.  I sat
down and took a look at the roken version of strptime.  I grabbed the code
and slapped it in time.cc.  I compiled a new version of the dll, and it
compiled right OOTB.  Here's how the top of the strptime function in
time.cc:
	extern "C"
	char *
	strptime (const char *buf, const char *format, struct tm *timeptr)

So far so good.  Since this was my first submission of new functionality to
the dll, I took heavy hints from Robert's earlier diffs submitted to the
list.  I added this to /usr/include/time.h:
	char      *_EXFUN(strptime,     (const char *, const char *, struct
tm *));

And to cygwin.din I added, right where Robert did:
	strptime

I rebuilt the dll like that.  It built no problems, and I swapped it in for
my working dll.  Relaunched bash, no problems.  I went back to my ported
version of utmpdump, stripped out my bad version of strptime, and tried to
recompile (assuming it would link up with cygwin1.dll and use the version
I'd just added).  The calling code included time.h, and the calling portion
of the code is:
	strptime(s_time, "%a %b %d %T %Y", tm);

When I compiled I got the following error:

$ make
gcc -Wall -O2 -D_GNU_SOURCE   -c -o utmpdump.o utmpdump.c
gcc -s -o utmpdump utmpdump.o
utmpdump.o(.text+0x1eb):utmpdump.c: undefined reference to `strptime'
collect2: ld returned 1 exit status
make: *** [utmpdump] Error 1

Hmm...  That was a head scratcher.  I added this to the
src/newlib/libc/include/time.h:
	char      *_EXFUN(strptime,     (const char *, const char *, struct
tm *));

Rebuilt and tried again.  Same thing.  I went back and changed cygwin.din to
say:
	strptime
	_strptime = strptime

Rinse, lather, repeat.  Same thing.  Since this is the first time I've tried
to add new functionality to cygwin1.dll I'd guess I'm missing something
obvious.  Can I get a push in the right direction?  Am I making the dll
wrong, or is there something else I'm missing?

Mark
