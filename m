Return-Path: <cygwin-patches-return-6195-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12386 invoked by alias); 13 Dec 2007 17:09:55 -0000
Received: (qmail 12372 invoked by uid 22791); 13 Dec 2007 17:09:55 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.180)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 13 Dec 2007 17:09:48 +0000
Received: by py-out-1112.google.com with SMTP id u52so1088342pyb.1         for <cygwin-patches@cygwin.com>; Thu, 13 Dec 2007 09:09:46 -0800 (PST)
Received: by 10.141.122.20 with SMTP id z20mr1229498rvm.293.1197565786012;         Thu, 13 Dec 2007 09:09:46 -0800 (PST)
Received: by 10.140.188.9 with HTTP; Thu, 13 Dec 2007 09:09:45 -0800 (PST)
Message-ID: <55c2fd8a0712130909h4b15552ckc209e4d928fbf970@mail.gmail.com>
Date: Thu, 13 Dec 2007 17:09:00 -0000
From: "Craig MacGregor" <cmacgreg@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] poll() return value is actually that of select()
In-Reply-To: <20071213105933.GC32462@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <55c2fd8a0712120959q7d8cec61vb37a24c569cfb0c2@mail.gmail.com> 	 <20071212185714.GD6618@calimero.vinschen.de> 	 <A6F1FD53-63C9-4137-A491-3A3E0475542D@zooko.com> 	 <20071213105933.GC32462@calimero.vinschen.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00047.txt.bz2

On Dec 13, 2007 5:59 AM, Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:

> As soon as Craig made a sanity check of my solution, I'll apply the
> patch to 1.5.25 as well.
>

Looks good to me, works... yes your way is simpler :)

-craig
