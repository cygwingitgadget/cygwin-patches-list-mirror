Return-Path: <cygwin-patches-return-4047-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10677 invoked by alias); 8 Aug 2003 19:31:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10664 invoked from network); 8 Aug 2003 19:31:20 -0000
Date: Fri, 08 Aug 2003 19:31:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] stdint.h define of INT32_MIN
Message-ID: <20030808193118.GA12540@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1231817066743.20030808133751@familiehaase.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1231817066743.20030808133751@familiehaase.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00063.txt.bz2

On Fri, Aug 08, 2003 at 01:37:51PM +0200, Gerrit P. Haase wrote:
>Hallo ,

"Hello"

>xyz.c:2: warning: this decimal constant is unsigned only in ISO C90
>
>Both of the below patches are ok. for me to build perl and also there
>are no warnings issued, the first is the way it is defined on Linux
>too, the second seems to be alright according to the SUS specs:
>
>$ diff -udp stdint.h~ stdint.h
>--- stdint.h~   2003-08-08 13:14:19.248036800 +0200
>+++ stdint.h    2003-08-08 13:14:36.452776000 +0200
>@@ -70,7 +70,7 @@ typedef unsigned long long uintmax_t;
> 
> #define INT8_MIN (-128)
> #define INT16_MIN (-32768)
>-#define INT32_MIN (-2147483648)
>+#define INT32_MIN (-2147483647-1)
> #define INT64_MIN (-9223372036854775808)
> 
> #define INT8_MAX (127)
>
># END

I've applied the above patch.

Thanks.

cgf
