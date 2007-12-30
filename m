Return-Path: <cygwin-patches-return-6224-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22714 invoked by alias); 30 Dec 2007 20:17:36 -0000
Received: (qmail 22704 invoked by uid 22791); 30 Dec 2007 20:17:35 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-37-220.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (96.233.37.220)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 30 Dec 2007 20:17:19 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id B26212B352; Sun, 30 Dec 2007 15:17:17 -0500 (EST)
Date: Sun, 30 Dec 2007 20:17:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Export fast *rint* functions
Message-ID: <20071230201717.GB2942@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <050e01c84401$be876720$2e08a8c0@CAM.ARTIMI.COM> <20071221234102.GA23118@trixie.casa.cgf.cx> <071a01c84a0d$b1b79d50$2e08a8c0@CAM.ARTIMI.COM> <20071229170412.GA24999@ednor.casa.cgf.cx> <074201c84a3f$64bf8fd0$2e08a8c0@CAM.ARTIMI.COM> <20071229172937.GB24999@ednor.casa.cgf.cx> <074a01c84a44$5459ec30$2e08a8c0@CAM.ARTIMI.COM> <20071229181025.GF24999@ednor.casa.cgf.cx> <074f01c84a46$deab17e0$2e08a8c0@CAM.ARTIMI.COM> <07ba01c84b20$337a0310$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ba01c84b20$337a0310$2e08a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00076.txt.bz2

On Sun, Dec 30, 2007 at 08:11:43PM -0000, Dave Korn wrote:
>On 29 December 2007 18:16, Dave Korn wrote:
>
>> On 29 December 2007 18:10, Christopher Faylor wrote:
>
>>> So check this in but you do also have to bump CYGWIN_VERSION_API_MINOR
>>> and document what you're exporting in include/cygwin/version.h along with
>>> these changes.
>> 
>>   Ach, right, I'm not au fait with the SOP.  I'll add those changes and
>> resend.
>
>2007-12-30  Dave Korn  <dave.korn@artimi.com>
>
>	* cygwin.din (_f_llrint, _f_llrintf, _f_llrintl, _f_lrint, _f_lrintf,
>	_f_lrintl, _f_rint, _f_rintf, _f_rintl):  Export fast *rint* functions.
>	(lrint, lrintf, rint, rintf):  Redirect exports to alias _f_ versions.
>	(llrint, llrintf, llrintl, lrintl, rintl):  Add exports aliasing _f_*
>	versions likewise.
>	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR):  Bump.

Looks good.  Please check in.

cgf
