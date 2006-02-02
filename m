Return-Path: <cygwin-patches-return-5738-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10671 invoked by alias); 2 Feb 2006 17:52:00 -0000
Received: (qmail 10651 invoked by uid 22791); 2 Feb 2006 17:51:59 -0000
X-Spam-Check-By: sourceware.org
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 02 Feb 2006 17:51:58 +0000
Received: from rainbow ([192.168.1.165]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830); 	 Thu, 2 Feb 2006 17:51:55 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: "'Daniel Jacobowitz'" <drow@false.org>
Cc: <cygwin-patches@cygwin.com>, 	<gdb-patches@sourceware.org>
Subject: RE: [patch] fix spurious SIGSEGV faults under Cygwin
Date: Thu, 02 Feb 2006 17:52:00 -0000
Message-ID: <009701c62821$5ae9a050$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20060202174600.GA5696@nevyn.them.org>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00047.txt.bz2

On 02 February 2006 17:46, 'Daniel Jacobowitz' wrote:

> "this information" does not refer to "if there is a debugger attached".


  Ah!  Thank you for solving my parsing problem!

  I still can't tell if that's because "this information" does not refer to the return value of IsDebuggerPresent, or because it
does but that return value does not detect gdb, but the feeling of utter bewilderment is subsiding somewhat!


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
