Return-Path: <cygwin-patches-return-3780-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24999 invoked by alias); 2 Apr 2003 18:29:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24990 invoked from network); 2 Apr 2003 18:29:37 -0000
Date: Wed, 02 Apr 2003 18:29:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix for GetModuleFileName() hang when address is in ntdll.dll (NT4 SP5)
Message-ID: <20030402182941.GC3147@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3E8AFF12.8040904@hekimian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8AFF12.8040904@hekimian.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q2/txt/msg00007.txt.bz2

On Wed, Apr 02, 2003 at 10:17:38AM -0500, Joe Buehler wrote:
>2003-04-02  Joe Buehler  <jhpb@hekimian.com>
>
>	* exceptions.cc (interruptible): avoid calling GetModuleFileName() 
>	on system DLL

There are two possible more, IMO, correct fixes for this.  1) Find out why GetModuleFileName
is hanging or 2) protect the function in cygwin which is blocking in a system DLL
with a 'sigframe thisframe (mainthread);'

This code used to have a test just like this.  It was changed to *use* GetModuleFileName.

cgf
