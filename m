Return-Path: <cygwin-patches-return-7990-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10310 invoked by alias); 26 May 2014 15:27:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10296 invoked by uid 89); 26 May 2014 15:27:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.2 required=5.0 tests=AWL,BAYES_20,FREEMAIL_FROM,KAM_COUK,SPF_PASS autolearn=no version=3.3.2
X-HELO: out.ipsmtp2nec.opaltelecom.net
Received: from out.ipsmtp2nec.opaltelecom.net (HELO out.ipsmtp2nec.opaltelecom.net) (62.24.202.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (CAMELLIA256-SHA encrypted) ESMTPS; Mon, 26 May 2014 15:27:14 +0000
X-SMTPAUTH: drstacey@tiscali.co.uk
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsgBAApcg1NV0kCB/2dsb2JhbAANTLF0kT6DEAGBKIMZAQEBBDhAEQsYCRYPCQMCAQIBRRMIAQG3JaZWF45ZFoQqAQOlCotJ
X-IPAS-Result: AsgBAApcg1NV0kCB/2dsb2JhbAANTLF0kT6DEAGBKIMZAQEBBDhAEQsYCRYPCQMCAQIBRRMIAQG3JaZWF45ZFoQqAQOlCotJ
Received: from 85-210-64-129.dynamic.dsl.as9105.com (HELO [192.168.1.67]) ([85.210.64.129])  by out.ipsmtp2nec.opaltelecom.net with ESMTP; 26 May 2014 16:27:11 +0100
Message-ID: <53835D4E.9040603@tiscali.co.uk>
Date: Mon, 26 May 2014 15:27:00 -0000
From: David Stacey <drstacey@tiscali.co.uk>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin_rexec() returns pointer to deallocated memory
References: <53811668.5010208@tiscali.co.uk> <5382E760.7@lysator.liu.se> <538312E4.1040201@tiscali.co.uk> <5383434B.8070508@lysator.liu.se>
In-Reply-To: <5383434B.8070508@lysator.liu.se>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q2/txt/msg00013.txt.bz2

On 26/05/14 14:36, Peter Rosin wrote:
> I believe the comment refers to if "static" is the right answer to the
> problem. Is there a need to handle concurrent calls?

I can't really comment on that. As the code stands, neither of the two 
functions that we are discussing are reentrant. As long as the author 
and the user(s) of the routines are both aware of that then it isn't a 
problem.

I was just trying to fix a coding error that was picked up by Coverity 
Scan; it wasn't my intention to question the design.

Cheers,

Dave.
