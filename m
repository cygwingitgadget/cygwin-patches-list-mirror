Return-Path: <cygwin-patches-return-2407-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26292 invoked by alias); 13 Jun 2002 03:53:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26278 invoked from network); 13 Jun 2002 03:53:17 -0000
Date: Wed, 12 Jun 2002 20:53:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
Message-ID: <20020613035344.GC14456@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020612230833.0080d100@mail.attbi.com> <3.0.5.32.20020612205711.007f7300@mail.attbi.com> <3.0.5.32.20020612205711.007f7300@mail.attbi.com> <3.0.5.32.20020612230833.0080d100@mail.attbi.com> <3.0.5.32.20020612233905.0080d100@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020612233905.0080d100@mail.attbi.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00390.txt.bz2

On Wed, Jun 12, 2002 at 11:39:05PM -0400, Pierre A. Humblet wrote:
>At 11:30 PM 6/12/2002 -0400, Christopher Faylor wrote:
>>  I'm assuming that you haven't looked at
>>the new code.  
>
>Correct, I had already done the work and updating cvs
>would wipe out my changes (the suboptimal way I am set up). 
>But I will, tomorrow.
>
>>My implementation goes a step further and tries to set
>>it only when it is actually needed for non-cygwin programs, assuming
>>that only non-cygwin Windows programs will be interested in most of the
>>environment variables.
>That's a good thing. I am curious to see how. I was hitting the
>fact that once you are impersonated LookupAccountSid won't work properly,
>so spawn_guts was the latest moment I could use it.
>
>>Ah.  Ok.  Should have read your explanation more closely.  I was using a
>>different definition of "parent_process".  You want to check
>>child_proc_info, then.  If it is non-NULL, the process has been
>>forked/execed.
>
>Which is exactly what I pass to uinfo_init!

It's a global variable!  It's used throughout cygwin!

cgf
