Return-Path: <cygwin-patches-return-3766-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21177 invoked by alias); 27 Mar 2003 16:31:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21168 invoked from network); 27 Mar 2003 16:31:47 -0000
Date: Thu, 27 Mar 2003 16:31:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] The great pthread rename
Message-ID: <20030327163214.GI12539@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0303271208480.486-200000@algeria.intern.net> <1048763903.5593.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048763903.5593.17.camel@localhost>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00415.txt.bz2

On Thu, Mar 27, 2003 at 10:18:23PM +1100, Robert Collins wrote:
>On Thu, 2003-03-27 at 22:11, Thomas Pfaff wrote:
>> Do not try to force me to comment every bit of this patch ;-)
>> 
>> 2003-03-27  Thomas Pfaff  <tpfaff@gmx.net>
>> 
>> 	* thread.h: Change class names, methods, members and local vars
>> 	according to the GNU coding style.
>> 	* thread.cc: Ditto.
>> 	* dcrt0.cc (dll_crt0_1): Rename pthread::initMainThread call to
>> 	pthread::init_mainthread.
>> 	* pthread.cc (pthead_getsequence_np): Rename pthread::isGoodObject
>> 	call to pthread::is_good_object.
>
>Reminds me why I don't require the GNU standards for setup.exe :}.
>
>Thanks, and please apply.

Thanks for doing this, but please don't feel compelled to fix every single
occurrence of this type of thing.  I really don't care that much.

cgf
