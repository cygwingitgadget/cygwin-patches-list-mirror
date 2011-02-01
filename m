Return-Path: <cygwin-patches-return-7159-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26840 invoked by alias); 1 Feb 2011 08:47:31 -0000
Received: (qmail 26819 invoked by uid 22791); 1 Feb 2011 08:47:23 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 01 Feb 2011 08:47:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 915A92C0328; Tue,  1 Feb 2011 09:47:15 +0100 (CET)
Date: Tue, 01 Feb 2011 08:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix bogus fsync() error
Message-ID: <20110201084715.GM1057@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D471106.4050304@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D471106.4050304@t-online.de>
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
X-SW-Source: 2011-q1/txt/msg00014.txt.bz2

On Jan 31 20:44, Christian Franke wrote:
> If used on raw devices like /dev/sda fsync() always fails with
> EBADRQC (54) because FlushFileBuffers() always fails with
> ERROR_INVALID_FUNCTION (1).
> 
> The attached patch fixes this by simply ignoring this error in the
> fhandler_base implementation. This should not affect any real flush
> errors which likely would return other error codes.
> 
> An alternative approach would be to ignore the error only in a new
> fhandler_raw_dev/floppy::fsync(). IMO not worth the effort is this
> case.

I agree.  I applied the patch.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
