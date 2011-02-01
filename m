Return-Path: <cygwin-patches-return-7160-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8445 invoked by alias); 1 Feb 2011 15:48:40 -0000
Received: (qmail 8415 invoked by uid 22791); 1 Feb 2011 15:48:38 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm21-vm0.bullet.mail.ac4.yahoo.com (HELO nm21-vm0.bullet.mail.ac4.yahoo.com) (98.139.53.216)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 01 Feb 2011 15:48:33 +0000
Received: from [98.139.52.192] by nm21.bullet.mail.ac4.yahoo.com with NNFMP; 01 Feb 2011 15:48:31 -0000
Received: from [74.6.228.50] by tm5.bullet.mail.ac4.yahoo.com with NNFMP; 01 Feb 2011 15:48:31 -0000
Received: from [127.0.0.1] by smtp109.mail.ac4.yahoo.com with NNFMP; 01 Feb 2011 15:48:31 -0000
Received: from cgf.cx (cgf@72.70.43.36 with login)        by smtp109.mail.ac4.yahoo.com with SMTP; 01 Feb 2011 07:48:31 -0800 PST
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 13C2B13C0C9	for <cygwin-patches@cygwin.com>; Tue,  1 Feb 2011 10:48:19 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 0E3446442B8; Tue,  1 Feb 2011 10:48:19 -0500 (EST)
Date: Tue, 01 Feb 2011 15:48:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix bogus fsync() error
Message-ID: <20110201154818.GA14218@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D471106.4050304@t-online.de> <20110201084715.GM1057@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110201084715.GM1057@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00015.txt.bz2

On Tue, Feb 01, 2011 at 09:47:15AM +0100, Corinna Vinschen wrote:
>On Jan 31 20:44, Christian Franke wrote:
>> If used on raw devices like /dev/sda fsync() always fails with
>> EBADRQC (54) because FlushFileBuffers() always fails with
>> ERROR_INVALID_FUNCTION (1).
>> 
>> The attached patch fixes this by simply ignoring this error in the
>> fhandler_base implementation. This should not affect any real flush
>> errors which likely would return other error codes.
>> 
>> An alternative approach would be to ignore the error only in a new
>> fhandler_raw_dev/floppy::fsync(). IMO not worth the effort is this
>> case.
>
>I agree.  I applied the patch.

Shouldn't this patch be a little more robust and check that you're getting
ERROR_INVALID_FUNCTION only for raw devices?

cgf
