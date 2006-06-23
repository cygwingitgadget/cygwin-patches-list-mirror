Return-Path: <cygwin-patches-return-5899-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29586 invoked by alias); 23 Jun 2006 13:20:48 -0000
Received: (qmail 29574 invoked by uid 22791); 23 Jun 2006 13:20:47 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 23 Jun 2006 13:20:40 +0000
Received: from mail.artimi.com ([192.168.1.3]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 23 Jun 2006 14:20:37 +0100
Received: from rainbow ([192.168.1.165]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 23 Jun 2006 14:20:36 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: "'Cygwin patches'" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] tcgetattr() doesn't support 50 baud
Date: Fri, 23 Jun 2006 13:20:00 -0000
Message-ID: <00f501c696c7$d09d8400$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <449BCFD1.4070007@gmail.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00087.txt.bz2

On 23 June 2006 12:26, Lapo Luchini wrote:

[ Thread TITTPL'd! ]

> Lapo Luchini wrote:
>> I'll try and add the support for B50 in in and send a patch ASAP.
>> 
> Modified, patched, and tested:
> 
> --- fhandler_serial.cc.orig    2006-01-16 18:14:36.000000000 +0100
> +++ fhandler_serial.cc    2006-06-23 11:49:26.000000000 +0200
> @@ -608,6 +608,9 @@
>       0 is an invalid bitrate in Win32 */
>        dropDTR = true;
>        break;
> +    case B50:
> +      state.BaudRate = 50;
> +      break;

  I suggest adding a comment here, as with the 230,400 baud case below,
explaining that there isn't a CBR_ symbol to use here.

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
