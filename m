Return-Path: <cygwin-patches-return-9537-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13862 invoked by alias); 31 Jul 2019 10:35:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13853 invoked by uid 89); 31 Jul 2019 10:35:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=detach, UD:cygwin.com, cygwincom, cygwin.com
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 31 Jul 2019 10:35:44 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 12:35:42 +0200
Received: from fril0049.wamas.com ([172.28.42.244] helo=wamas.com)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <haubi@wamas.com>)	id 1hslxN-0000IF-IA; Wed, 31 Jul 2019 12:35:41 +0200
Received: with nullmailer 2.2;	Wed, 31 Jul 2019 10:35:41 -0000
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH v2 0/2] silent fork retry with shm (broke emacs-X11)
Date: Wed, 31 Jul 2019 10:35:00 -0000
Message-Id: <20190731103531.559-1-michael.haubenwallner@ssi-schaefer.com>
In-Reply-To: <20190730160754.GZ11632@calimero.vinschen.de>
References: <20190730160754.GZ11632@calimero.vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SW-Source: 2019-q3/txt/msg00057.txt.bz2

Hi Corinna,

On 7/30/19 6:07 PM, Corinna Vinschen wrote:
> Hi Michael,
> 
> On Jul 30 17:22, Michael Haubenwallner wrote:
>> Hi,
>>
>> following up
>> https://cygwin.com/ml/cygwin-patches/2019-q2/msg00155.html
>>
>> It turns out that fixup_shms_after_fork does require the child pinfo to
>> be "remember"ed, while the fork retry to be silent on failure requires
>> the child to not be "attach"ed yet.
>>
>> As current pinfo.remember performs both "remember" and "attach" at once,
>> the first patch does introduce pinfo.remember_without_attach, to not
>> change current behaviour of pinfo.remember and keep patches small.
>>
>> However, my first thought was to clean up pinfo API a little and have
>> remember not do both "remember+attach" at once, but introduce some new
>> remember_and_attach method instead.  But then, when 'bool detach' is
>> true, the "_and_attach" does feel wrong.
> 
> I'd prefer to drop the reattach call from remember, calling both of them
> where appropriate.
> 

Fine with me, even if that looks a little more complicated for spawn.

Thanks!
/haubi/

