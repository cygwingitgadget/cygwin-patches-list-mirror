Return-Path: <cygwin-patches-return-4678-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31549 invoked by alias); 13 Apr 2004 12:18:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31536 invoked from network); 13 Apr 2004 12:18:50 -0000
Date: Tue, 13 Apr 2004 12:18:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: path.cc
Message-ID: <20040413121849.GB26558@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040410110343.GM26558@cygbert.vinschen.de> <3.0.5.32.20040404234622.00800100@incoming.verizon.net> <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net> <3.0.5.32.20040403214940.007f2650@incoming.verizon.net> <3.0.5.32.20040403214940.007f2650@incoming.verizon.net> <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net> <3.0.5.32.20040404234622.00800100@incoming.verizon.net> <3.0.5.32.20040409231957.00857bb0@incoming.verizon.net> <20040410110343.GM26558@cygbert.vinschen.de> <3.0.5.32.20040412190645.00809e10@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040412190645.00809e10@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00030.txt.bz2

On Apr 12 19:06, Pierre A. Humblet wrote:
> I have also observed abnormal behavior on NT4.0
> 1) ls uses ntsec even on remote drives without smbntsec
> 
> /> echo $CYGWIN
> bash: CYGWIN: unbound variable
> ~> uname -a
> CYGWIN_NT-4.0 myhost 1.5.9(0.112/4/2) 2004-03-18 23:05 i686 unknown unknown
> Cygwin
> ~> ls -ld ~
> drwxr-xr-x    1 PHumblet Clearuse        0 Apr 12 10:16 /h/

Woops, I got a write accessor wrong.  Fixed and changed to be somewhat
cleaner defined.

> ~> uname -a
> CYGWIN_NT-4.0 myhost 1.5.10(0.113/4/2) 2004-04-12 00:16 i686 unknown
> unknown Cygwin
> ~> ls -ld ~
> d---------+  22 Administ Domain A        0 Apr 12 10:16 /h/
> 
> 
> 2) The system has become unbearably slow.
>  
>  2771   45904 [main] ls 410 get_file_attribute: file: h:\Job
> 1091290 1137194 [main] ls 410 cygpsid::debug_print: get_sids_info: owner
> SID = S-1-5-32-544
> 
> I think it's related to
> http://www.cygwin.com/ml/cygwin/2003-03/msg01760.html

Fortunately these NT 4 bugs are Win32 API bugs, not native NT API bugs.
I replaced the whole get_nt_object_attribute functionality by calls
to the native NtQuerySecurityObject function and tested on NT 4.  File
access as well as registry access are both as quick as on my XP system
now, AFAICS.

Thanks for the report,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
