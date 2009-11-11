Return-Path: <cygwin-patches-return-6834-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12685 invoked by alias); 11 Nov 2009 18:19:49 -0000
Received: (qmail 12675 invoked by uid 22791); 11 Nov 2009 18:19:49 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f223.google.com (HELO mail-fx0-f223.google.com) (209.85.220.223)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 11 Nov 2009 18:19:43 +0000
Received: by fxm23 with SMTP id 23so1429360fxm.18         for <cygwin-patches@cygwin.com>; Wed, 11 Nov 2009 10:19:41 -0800 (PST)
Received: by 10.216.87.20 with SMTP id x20mr558853wee.158.1257963581257;         Wed, 11 Nov 2009 10:19:41 -0800 (PST)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id m5sm5703947gve.26.2009.11.11.10.19.38         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Wed, 11 Nov 2009 10:19:39 -0800 (PST)
Message-ID: <4AFB0042.90602@users.sourceforge.net>
Date: Wed, 11 Nov 2009 18:19:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add get_nprocs, get_nprocs_conf
References: <4AFA6675.6070408@users.sourceforge.net> <20091111094119.GA3564@calimero.vinschen.de> <4AFA907E.1050408@users.sourceforge.net> <4AFAB42C.1020404@byu.net>
In-Reply-To: <4AFAB42C.1020404@byu.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00165.txt.bz2

On 11/11/2009 06:55, Eric Blake wrote:
> +1 on the concept from me, although why does sys/sysinfo.h have to
> forward to cygwin/sysinfo.h, rather than directly declaring the two functions?

I simply followed the pattern of many of the sys/*.h headers, and by 
their copyright dates are relatively newer, which redirected to a 
cygwin/*.h equivalent.  If there is supposed to be some rhyme and reason 
to which ones redirect and which ones do not, please feel free to clue 
me in. :-)


Yaakov
