Return-Path: <cygwin-patches-return-7639-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23067 invoked by alias); 17 Apr 2012 07:06:51 -0000
Received: (qmail 22785 invoked by uid 22791); 17 Apr 2012 07:06:30 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 17 Apr 2012 07:06:17 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4392F2C006F; Tue, 17 Apr 2012 09:06:15 +0200 (CEST)
Date: Tue, 17 Apr 2012 07:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Setting TZ may break time() in non-Cygwin programs
Message-ID: <20120417070615.GA22155@calimero.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4F4FD8C6.5000807@t-online.de> <20120302091317.GD14404@calimero.vinschen.de> <4F513D11.2080203@t-online.de> <20120304115232.GC18852@calimero.vinschen.de> <4F53B791.2090709@t-online.de> <20120304204938.GL18852@calimero.vinschen.de> <4F85D2F4.8090204@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4F85D2F4.8090204@t-online.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q2/txt/msg00008.txt.bz2

Hi Christian,

On Apr 11 20:52, Christian Franke wrote:
> Yes. Patch is attached.
> 
> Christian
> 

Thanks for the patch.  I'm just wondering if we shouldn't generalize
this right from the start by keeping an array of variables to skip
when starting native apps and a function to handle this, along the
lines of the getwinenv function and the conv_envvars array.
It might only contain TZ now, but there's always a chance we suddenly
stumble over a similar problem, isn't it?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
