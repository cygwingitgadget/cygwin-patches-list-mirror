Return-Path: <cygwin-patches-return-2864-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20707 invoked by alias); 26 Aug 2002 02:33:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20693 invoked from network); 26 Aug 2002 02:33:44 -0000
Message-ID: <00c501c24ca9$a2be9c20$c3823bd5@dmitry>
From: "Dmitry Timoshkov" <dmitry@baikal.ru>
To: "Bart Oldeman" <bart.oldeman@btinternet.com>,
        "Danny Smith" <danny_r_smith_2001@yahoo.co.nz>
Cc: <cygwin-patches@cygwin.com>
References: <Pine.LNX.4.33.0208252247200.9978-100000@enm-bo-lt.enm.bris.ac.uk>
Subject: Re: [PATCH] winsock related changes for w32api
Date: Sun, 25 Aug 2002 19:33:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-SW-Source: 2002-q3/txt/msg00312.txt.bz2

"Bart Oldeman" <bart.oldeman@btinternet.com> wrote:

> > Shouldn't structs and protos  be Unicoded properly, rather than using LPTSTR
> 
> LPTSTR should be fine, since:
> <winnt.h>:
> typedef TCHAR *LPTCH,*PTSTR,*LPTSTR,*LP,*PTCHAR;
> and
> #ifdef UNICODE
> typedef WCHAR TCHAR;
> #else
> typedef CHAR TCHAR;
> #endif

No, LPTSTR is not enough in order to use ANSI and Unicode APIs simultaneously.
Have a look at the Platform SDK headers how to do it properly.

-- 
Dmitry.


