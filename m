Return-Path: <cygwin-patches-return-6183-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23955 invoked by alias); 11 Dec 2007 15:24:43 -0000
Received: (qmail 23945 invoked by uid 22791); 11 Dec 2007 15:24:43 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 11 Dec 2007 15:24:39 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Tue, 11 Dec 2007 15:24:36 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
References: <0b0d01c83bef$e9364690$2e08a8c0@CAM.ARTIMI.COM> <20071211141852.GA3619@ednor.casa.cgf.cx> <0b1e01c83c01$cb11e2c0$2e08a8c0@CAM.ARTIMI.COM> <20071211143847.GA3719@ednor.casa.cgf.cx>
Subject: RE: Cygheap page boundary allocation bug.
Date: Tue, 11 Dec 2007 15:24:00 -0000
Message-ID: <0b2301c83c09$f075e6d0$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20071211143847.GA3719@ednor.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00035.txt.bz2

On 11 December 2007 14:39, Christopher Faylor wrote:

> On Tue, Dec 11, 2007 at 02:26:17PM -0000, Dave Korn wrote:
>> On 11 December 2007 14:19, Christopher Faylor wrote:
>> 
>>> On Tue, Dec 11, 2007 at 12:18:17PM -0000, Dave Korn wrote:
>>>> 2007-12-11  Dave Korn  <dave.korn@artimi.com>
>>>> 
>>>> 	* cygheap.cc (_csbrk):  Don't request zero bytes from VirtualAlloc,
>>>> 	as windows treats that as an invalid parameter and returns an error.
>>> 
>>> Ok.
>> 
>>  Trunk or cr-0x5f1 branch or both or ... ?
> 
> Trunk.  If Corinna wants it on the branch I'm sure she'll apply it.

  Applied, thanks.  (Found some problems in w32api's wincrypt.h which I'll
report to mingw list later today.  Appears to have been there for at least a
fortnight.  Am I the only one who builds with WINVER >= 0x0501?)

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
