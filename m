Return-Path: <cygwin-patches-return-2406-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22447 invoked by alias); 13 Jun 2002 03:42:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22432 invoked from network); 13 Jun 2002 03:42:00 -0000
Message-Id: <3.0.5.32.20020612233905.0080d100@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Wed, 12 Jun 2002 20:42:00 -0000
To: cygwin-patches@cygwin.com,cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Reorganizing internal_getlogin()
In-Reply-To: <20020613033021.GB14456@redhat.com>
References: <3.0.5.32.20020612230833.0080d100@mail.attbi.com>
 <3.0.5.32.20020612205711.007f7300@mail.attbi.com>
 <3.0.5.32.20020612205711.007f7300@mail.attbi.com>
 <3.0.5.32.20020612230833.0080d100@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00389.txt.bz2

At 11:30 PM 6/12/2002 -0400, Christopher Faylor wrote:
>  I'm assuming that you haven't looked at
>the new code.  

Correct, I had already done the work and updating cvs
would wipe out my changes (the suboptimal way I am set up). 
But I will, tomorrow.

>My implementation goes a step further and tries to set
>it only when it is actually needed for non-cygwin programs, assuming
>that only non-cygwin Windows programs will be interested in most of the
>environment variables.
That's a good thing. I am curious to see how. I was hitting the
fact that once you are impersonated LookupAccountSid won't work properly,
so spawn_guts was the latest moment I could use it.

>Ah.  Ok.  Should have read your explanation more closely.  I was using a
>different definition of "parent_process".  You want to check
>child_proc_info, then.  If it is non-NULL, the process has been
>forked/execed.

Which is exactly what I pass to uinfo_init!
Good night.

Pierre
