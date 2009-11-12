Return-Path: <cygwin-patches-return-6838-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28083 invoked by alias); 12 Nov 2009 10:46:12 -0000
Received: (qmail 28072 invoked by uid 22791); 12 Nov 2009 10:46:11 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from service1.sh.cvut.cz (HELO service1.sh.cvut.cz) (147.32.127.214)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 12 Nov 2009 10:46:05 +0000
Received: from localhost (localhost [127.0.0.1]) 	by service1.sh.cvut.cz (Postfix) with ESMTP id 6CA28124B1F; 	Thu, 12 Nov 2009 11:46:03 +0100 (CET)
X-Spam-Score: -80.301
Received: from service1.sh.cvut.cz ([127.0.0.1]) 	by localhost (service1.sh.cvut.cz [127.0.0.1]) (amavisd-new, port 10024) 	with ESMTP id i1OE48S755mY; Thu, 12 Nov 2009 11:45:55 +0100 (CET)
Received: from [192.168.111.233] (eccam.com [82.113.60.26]) 	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) 	(No client certificate requested) 	(Authenticated sender: v.haisman@sh.cvut.cz) 	by service1.sh.cvut.cz (Postfix) with ESMTP id B3895124AFB; 	Thu, 12 Nov 2009 11:45:55 +0100 (CET)
Message-ID: <4AFBE763.4090002@sh.cvut.cz>
Date: Thu, 12 Nov 2009 10:46:00 -0000
From: =?ISO-8859-1?Q?V=E1clav_Haisman?= <v.haisman@sh.cvut.cz>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add get_nprocs, get_nprocs_conf
References: <4AFA6675.6070408@users.sourceforge.net>  <20091111094119.GA3564@calimero.vinschen.de>  <4AFA907E.1050408@users.sourceforge.net>  <4AFAB42C.1020404@byu.net>  <4AFB0042.90602@users.sourceforge.net>  <20091111202106.GA17519@ednor.casa.cgf.cx> <20091112094424.GA12637@calimero.vinschen.de> <4AFBDF1A.9020606@users.sourceforge.net>
In-Reply-To: <4AFBDF1A.9020606@users.sourceforge.net>
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
X-SW-Source: 2009-q4/txt/msg00169.txt.bz2

Yaakov (Cygwin/X) wrote:
> On 12/11/2009 03:44, Corinna Vinschen wrote:
>> In this case I'm rather surprised that these very GNU/Linux specific
>> things are *not* in a linux/sysinfo.h file.  But it doesn't hurt to keep
>> that in line with Linux, right?
> 
> In that case, here is a patch which declares directly in sys/sysinfo.h.
Isn't the new header missing extern "C" guard for C++?

--
VH
