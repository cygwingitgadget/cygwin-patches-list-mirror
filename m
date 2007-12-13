Return-Path: <cygwin-patches-return-6191-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7175 invoked by alias); 13 Dec 2007 00:07:29 -0000
Received: (qmail 7165 invoked by uid 22791); 13 Dec 2007 00:07:29 -0000
X-Spam-Check-By: sourceware.org
Received: from nooxie.zooko.com (HELO nooxie.zooko.com) (207.7.131.41)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 13 Dec 2007 00:07:02 +0000
Received: from [192.168.69.137] (dsl081-024-069.sfo1.dsl.speakeasy.net [64.81.24.69]) 	by nooxie.zooko.com (Postfix) with ESMTP id 5F48A3DDAD 	for <cygwin-patches@cygwin.com>; Wed, 12 Dec 2007 17:11:25 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <20071212185714.GD6618@calimero.vinschen.de>
References: <55c2fd8a0712120959q7d8cec61vb37a24c569cfb0c2@mail.gmail.com> <20071212185714.GD6618@calimero.vinschen.de>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A6F1FD53-63C9-4137-A491-3A3E0475542D@zooko.com>
Content-Transfer-Encoding: 7bit
From: zooko <zooko@zooko.com>
Subject: Re: [patch] poll() return value is actually that of select()
Date: Thu, 13 Dec 2007 00:07:00 -0000
To: cygwin-patches@cygwin.com
X-Mailer: Apple Mail (2.752.3)
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00043.txt.bz2

By the way, there is currently a patch pending in Python to work- 
around this bug in cygwin poll [1].

If you guys are accepting this patch to fix cygwin poll then I'll let  
the python developers know that.

Regards,

Zooko

[1] http://bugs.python.org/issue1759997
