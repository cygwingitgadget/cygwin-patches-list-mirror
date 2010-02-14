Return-Path: <cygwin-patches-return-6965-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3881 invoked by alias); 14 Feb 2010 17:19:18 -0000
Received: (qmail 3869 invoked by uid 22791); 14 Feb 2010 17:19:17 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.149)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 14 Feb 2010 17:19:12 +0000
Received: by ey-out-1920.google.com with SMTP id 4so1538733eyg.14         for <cygwin-patches@cygwin.com>; Sun, 14 Feb 2010 09:19:10 -0800 (PST)
Received: by 10.213.50.140 with SMTP id z12mr1124783ebf.89.1266167950159;         Sun, 14 Feb 2010 09:19:10 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm6760106eyb.10.2010.02.14.09.19.08         (version=SSLv3 cipher=RC4-MD5);         Sun, 14 Feb 2010 09:19:08 -0800 (PST)
Message-ID: <4B7834AD.3040606@gmail.com>
Date: Sun, 14 Feb 2010 17:19:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <20100213113509.GJ5683@calimero.vinschen.de>  <4B76C334.8080101@cwilson.fastmail.fm> <20100213210122.GA20649@ednor.casa.cgf.cx> <4B773B70.8040208@cwilson.fastmail.fm> <4B778315.9090300@gmail.com> <4B778E43.5020701@cwilson.fastmail.fm>
In-Reply-To: <4B778E43.5020701@cwilson.fastmail.fm>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00081.txt.bz2

On 14/02/2010 05:46, Charles Wilson wrote:
> Dave Korn wrote:
>> On 13/02/2010 23:53, Charles Wilson wrote:
>>
>>> http://cygwin.com/ml/cygwin-developers/2009-10/msg00242.html
>>> IIRC at that time Corinna suggested that newlib was the appropriate
>>> place for this, if I wanted to contribute it post-1.7.1. 
>> http://cygwin.com/ml/cygwin-developers/2009-10/msg00254.html
>>
>>> I asked how to
>>> go about adding something to newlib that might not work for all targets,
>>> and she said:
>>> Unfortunately, my google-foo is not strong enough to find that message
>>> in the cygwin archives, 
>> http://cygwin.com/ml/cygwin-developers/2009-10/msg00259.html
> 
> I bow to your superior google-foo. 

  I just went from the first post you listed to the thread view and read all
the followups.  More like mechanical turk version of a search algorithm than
any kind of google-fu on my part!

  ObTopic: I think newlib would be a nice place to put this functionality,
particularly since you've already gone to the trouble of fitting it into the
framework.  It's entirely plausible that the newlib linux targets would find
this code useful as well.  "Small embedded system" doesn't mean "not
network-connected" any more these days, not by a long way, so I think it is a
suitable and appropriate thing to propose adding to newlib.

    cheers,
      DaveK
