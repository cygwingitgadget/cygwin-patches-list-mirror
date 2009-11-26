Return-Path: <cygwin-patches-return-6855-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17855 invoked by alias); 26 Nov 2009 11:57:49 -0000
Received: (qmail 17844 invoked by uid 22791); 26 Nov 2009 11:57:49 -0000
X-SWARE-Spam-Status: No, hits=-0.4 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from mail15.tpgi.com.au (HELO mail15.tpgi.com.au) (203.12.160.61)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 26 Nov 2009 11:57:41 +0000
X-TPG-Junk-Checked: Yes
X-TPG-Junk-Status: Message not scanned because user authenticated using SMTP AUTH
X-TPG-Abuse: host=123-243-74-63.tpgi.com.au; ip=123.243.74.63; date=Thu, 26 Nov 2009 22:57:39 +1100; auth=a/dd58RmThMRQbJLhdmDwr/fcSovfa0vOzWc399V3Kc=
Received: from [10.1.1.3] (123-243-74-63.tpgi.com.au [123.243.74.63]) 	(authenticated bits=0) 	by mail15.tpgi.com.au (envelope-from helium@shaddybaddah.name) (8.14.3/8.14.3) with ESMTP id nAQBvaRH017917 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) 	for <cygwin-patches@cygwin.com>; Thu, 26 Nov 2009 22:57:39 +1100
Message-ID: <4B0E6D0B.8070501@shaddybaddah.name>
Date: Thu, 26 Nov 2009 11:57:00 -0000
From: Shaddy Baddah <helium@shaddybaddah.name>
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] override-able installation_root
References: <4B0D3920.3020907@shaddybaddah.name> <20091126112042.GO29173@calimero.vinschen.de>
In-Reply-To: <20091126112042.GO29173@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
X-SW-Source: 2009-q4/txt/msg00186.txt.bz2

Hi,

Corinna Vinschen wrote:
> Sorry, but no.  We won't accept this patch.  We have deliberately chosen
> to get away from the dependency to the Windows registry, and we really
> don't want to add it back again.
>   
Thank you for the response. Fair enough. But is it no to the idea of an 
overridable installation_root, or to doing by way of a registry setting? 
Is there another way to do this that would be reasonable? Say the use of 
an environment variable? Other?
> Btw., for a non-trivial patch like this you need to file a copyright
> assignment.  See http://cygwin.com/contrib.html, the "Before you get
> started" section.
>   
Fair enough. I estimated that it was trivial, but I accept that it isn't.

> That's on my TODO list and PTC.  It will have to wait until after 1.7.1
> as well, though.
>   
I'll ask around about copyright assignment. If I can get that sorted, 
I'll try and help with that effort.

Best regards,
Shaddy
