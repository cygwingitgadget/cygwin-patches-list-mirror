Return-Path: <cygwin-patches-return-2594-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2298 invoked by alias); 3 Jul 2002 15:48:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2283 invoked from network); 3 Jul 2002 15:48:11 -0000
Date: Wed, 03 Jul 2002 08:48:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Backwards?
Message-ID: <20020703154822.GF24177@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <027001c2229d$825a96e0$6132bc3e@BABEL> <02c501c2229e$1dc9d960$1800a8c0@LAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c501c2229e$1dc9d960$1800a8c0@LAPTOP>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00042.txt.bz2

On Thu, Jul 04, 2002 at 12:30:00AM +1000, Robert Collins wrote:
>You're right. I think that is :}.
>
>Uhmm, I think I had it deliberatly wrong whilst I got the cygserver security
>access calls working just right.

I think you're right, too, Conrad.  Could you check in your fix?

I puzzled over this for a while last night myself but I obviously didn't
apply enough neurons to the process.

cgf

>> Yesterday the following fragment of code from tty.cc confused me
>> because it used small_print rather than system_printf (speedily fixed
>> by Chris).  Now I'm confused because I don't understand the logic:
>>
>>   if (wincap.has_security ()
>>        && cygserver_running == CYGSERVER_OK
>>        && (SetKernelObjectSecurity (hMainProc,
>>             ACL_SECURITY_INFORMATION,
>>             get_null_sd ()) == FALSE))
>>     small_printf ("Can't set process security, %E");
>>
>> The call to SetKernelObjectSecurity was in the file before the
>> cygserver changes were added, i.e. the code used to be (before the
>> first cygwin_daemon merge):
>>
>>   if ((iswinnt) &&
>>       (SetKernelObjectSecurity (hMainProc,
>>                DACL_SECURITY_INFORMATION,
>>                get_null_sd ()) == FALSE))
>>     small_printf ("Can't set process security, %E");
>>
>> On that basis, shouldn't the test for cygserver be reversed:
>>
>>     if (... && cygserver != CYGSERVER_OK && ...)
>>
>> i.e. if cygserver isn't running, act as before?
>>
>> I don't understand quite this code is trying to achieve or why but,
>> assuming it's wrong, I've attached a patch to reverse the test. I've
>> checked this on the cygwin_daemon branch, both with and without
>> cygserver running, and can see no difference (this is with both
>> processes running as the same user tho').
>>
>> If someone could confirm / deny / explain this or even just wave their
>> hands around a bit and waffle, it would make me happier :-)
>>
>> // Conrad
>>
>>
