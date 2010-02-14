Return-Path: <cygwin-patches-return-6964-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3121 invoked by alias); 14 Feb 2010 17:15:40 -0000
Received: (qmail 3109 invoked by uid 22791); 14 Feb 2010 17:15:40 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.146)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 14 Feb 2010 17:15:35 +0000
Received: by ey-out-1920.google.com with SMTP id 4so1537345eyg.14         for <cygwin-patches@cygwin.com>; Sun, 14 Feb 2010 09:15:32 -0800 (PST)
Received: by 10.213.109.203 with SMTP id k11mr2909317ebp.47.1266167732476;         Sun, 14 Feb 2010 09:15:32 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 24sm13164804eyx.14.2010.02.14.09.15.30         (version=SSLv3 cipher=RC4-MD5);         Sun, 14 Feb 2010 09:15:31 -0800 (PST)
Message-ID: <4B7833D4.5090301@gmail.com>
Date: Sun, 14 Feb 2010 17:15:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <20100213113509.GJ5683@calimero.vinschen.de>  <4B76C334.8080101@cwilson.fastmail.fm>  <20100213210122.GA20649@ednor.casa.cgf.cx> <20100214101834.GO5683@calimero.vinschen.de>
In-Reply-To: <20100214101834.GO5683@calimero.vinschen.de>
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
X-SW-Source: 2010-q1/txt/msg00080.txt.bz2

On 14/02/2010 10:18, Corinna Vinschen wrote:

> I don't know if that works, but it would be really cool if a single
> DLL import lib like libcygwin.a could export symbols from different
> DLLs.  That way we could create a cygxdr1.dll which contains the XDR
> functions, but which could be linked against by just the default linking
> against libcygwin.a.

  Why would we do that?

    cheers,
      DaveK
