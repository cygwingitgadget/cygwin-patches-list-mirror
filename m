Return-Path: <cygwin-patches-return-6271-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9011 invoked by alias); 9 Mar 2008 14:38:38 -0000
Received: (qmail 9000 invoked by uid 22791); 9 Mar 2008 14:38:38 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-250.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.250)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 09 Mar 2008 14:38:21 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 090566D9667; Sun,  9 Mar 2008 10:38:20 -0400 (EDT)
Date: Sun, 09 Mar 2008 14:38:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
Message-ID: <20080309143819.GB8192@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080309092806.GW18407@calimero.vinschen.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00045.txt.bz2

On Sun, Mar 09, 2008 at 10:28:06AM +0100, Corinna Vinschen wrote:
>Hi Brian,
>
>Thanks for your patch.  I have a few nits, sorry.
>
>On Mar  8 20:13, Brian Dessent wrote:
>> Index: cygcheck.cc
>> ===================================================================
>> RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
>> retrieving revision 1.97
>> diff -u -p -r1.97 cygcheck.cc
>> --- cygcheck.cc	13 Jan 2008 13:41:45 -0000	1.97
>> +++ cygcheck.cc	9 Mar 2008 03:52:07 -0000
>> @@ -807,6 +807,31 @@ ls (char *f)
>>      display_error ("ls: CloseHandle()");
>>  }
>>  
>> +/* If s is non-NULL, save the CWD in a static buffer and set the CWD
>> +   to the dirname part of s.  If s is NULL, restore the CWD last
>> +   saved.  */
>> +static
>> +void save_cwd_helper (const char *s)
>> +{
>> +  static char cwdbuf[MAX_PATH + 1];
>> +  char dirnamebuf[MAX_PATH + 1];
>> +
>> +  if (s)
>> +    {
>> +      GetCurrentDirectory (sizeof (cwdbuf), cwdbuf);
>> +
>> +      /* Remove the filename part from s.  */
>> +      strncpy (dirnamebuf, s, MAX_PATH);
>> +      dirnamebuf[MAX_PATH] = '\0';   // just in case strlen(s) > MAX_PATH
>> +      char *lastsep = strrchr (dirnamebuf, '\\');
>> +      if (lastsep)
>> +        lastsep[1] = '\0';
>> +      SetCurrentDirectory (dirnamebuf);
>> +    }
>> +  else
>> +    SetCurrentDirectory (cwdbuf);
>> +}
>
>Given that Cygwin changes to support long path names, I don't really
>like to see new code still using MAX_PATH and Win32 Ansi functions
>in the utils dir.  I know that the Win32 cwd is always restricted to
>259 chars.  However, there *is* a way to recognize the current working
>directory of the parent Cygwin application.
>
>Bash as well as tcsh, as well as zsh (and probbaly pdksh, too) create an
>environment variable $PWD.  Maybe Cygwin should create $PWD for native
>apps if it's not already available through the parent shell.

I'd really rather not do that.  I don't think Cygwin should be polluting
the environment any more than it has to.  Even if this worked, it is
easily defeatable by setting a PWD environment variable before running
cygwin, so you'd have to keep track of this value through multiple
levels of process invocation.

I know everyone hates it but a cygwin_internal interface could be used
to get the current working directory for applications that need it.  I
would think that only mingw-like applications working in close
conjunction with cygwin would care about this.

cgf
