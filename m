Return-Path: <cygwin-patches-return-5892-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9254 invoked by alias); 13 Jun 2006 11:19:47 -0000
Received: (qmail 9241 invoked by uid 22791); 13 Jun 2006 11:19:45 -0000
X-Spam-Check-By: sourceware.org
Received: from Unknown (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 13 Jun 2006 11:19:43 +0000
Received: from mail.artimi.com ([192.168.1.3]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Tue, 13 Jun 2006 12:19:40 +0100
Received: from rainbow ([192.168.1.165]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Tue, 13 Jun 2006 12:19:40 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: Open sockets non-overlapped?
Date: Tue, 13 Jun 2006 11:19:00 -0000
Message-ID: <02e701c68edb$433beaa0$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <ba40711f0606130411m5d56ecc0jae17571d7d192d44@mail.gmail.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00080.txt.bz2

On 13 June 2006 12:12, Lev Bishop wrote:

> On 6/13/06, Corinna Vinschen wrote:
>> On Jun 12 22:59, Lev Bishop wrote:
>>> Ok. I just did setup sshd, and I do see those issues, or something
>>> similar (pressing the return key doesn't seem to help with the
>>> interactive logon for me). I wonder what sshd does that everything
>>> else i was using doesn't do.
>> 
>> Non-blocking sockets?  User context switching?
> 
> Possibly. But my money right now is on fork()ing.
> 
> Lev


  Have either of you tried CYGWIN=tty vs. CYGWIN=notty in testing this?

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
