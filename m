Return-Path: <cygwin-patches-return-7583-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25550 invoked by alias); 2 Jan 2012 17:55:33 -0000
Received: (qmail 25540 invoked by uid 22791); 2 Jan 2012 17:55:32 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 02 Jan 2012 17:55:19 +0000
Received: from pool-173-76-50-112.bstnma.fios.verizon.net ([173.76.50.112] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1Rhm6Q-000Jsp-IS	for cygwin-patches@cygwin.com; Mon, 02 Jan 2012 17:55:18 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 0175513C022	for <cygwin-patches@cygwin.com>; Mon,  2 Jan 2012 12:55:17 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18uQBH16FSSxOt8xwAGs+h/
Date: Mon, 02 Jan 2012 17:55:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add get_current_dir_name(3)
Message-ID: <20120102175517.GA9433@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1325385907.4064.7.camel@YAAKOV04> <20120101064630.GB3446@ednor.casa.cgf.cx> <1325402005.2376.5.camel@YAAKOV04> <4F01A97A.7060503@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F01A97A.7060503@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00006.txt.bz2

On Mon, Jan 02, 2012 at 05:56:26AM -0700, Eric Blake wrote:
>On 01/01/2012 12:13 AM, Yaakov (Cygwin/X) wrote:
>>> > You have to check st_dev here too don't you?
>> Of course.  Revised patch for winsup/cygwin attached.
>> 
>
>> +extern "C" char *
>> +get_current_dir_name (void)
>> +{
>> +  char *pwd = getenv ("PWD");
>> +  char *cwd = getcwd (NULL, 0);
>> +
>> +  if (pwd)
>> +    {
>> +      struct __stat64 pwdbuf, cwdbuf;
>> +      stat64 (pwd, &pwdbuf);
>> +      stat64 (cwd, &cwdbuf);
>> +      if ((pwdbuf.st_dev == cwdbuf.st_dev) && (pwdbuf.st_ino == cwdbuf.st_ino))
>> +        {
>> +          cwd = (char *) malloc (strlen (pwd) + 1);
>
>Memory leak.  You need to free(cwd) before reassigning it.  And why are
>you using malloc(strlen())/strcpy(), when you could just use strdup()?

Oops.  Eric is right.  Also, there should have been some error checking
for the stat calls since PWD is user-settable and could be bogus.  I'll
make those changes.

cgf
