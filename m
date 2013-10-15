Return-Path: <cygwin-patches-return-7905-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22346 invoked by alias); 15 Oct 2013 20:45:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22327 invoked by uid 89); 15 Oct 2013 20:45:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-pd0-f173.google.com
Received: from mail-pd0-f173.google.com (HELO mail-pd0-f173.google.com) (209.85.192.173) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Tue, 15 Oct 2013 20:45:09 +0000
Received: by mail-pd0-f173.google.com with SMTP id p10so9414584pdj.32        for <cygwin-patches@cygwin.com>; Tue, 15 Oct 2013 13:45:08 -0700 (PDT)
X-Received: by 10.68.101.225 with SMTP id fj1mr43667354pbb.8.1381869908001;        Tue, 15 Oct 2013 13:45:08 -0700 (PDT)
Received: from [192.168.0.101] (S0106000cf16f58b1.wp.shawcable.net. [24.79.212.134])        by mx.google.com with ESMTPSA id dq3sm86508151pbc.35.1969.12.31.16.00.00        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);        Tue, 15 Oct 2013 13:45:06 -0700 (PDT)
Message-ID: <525DA954.2040700@users.sourceforge.net>
Date: Tue, 15 Oct 2013 20:45:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: fix off-by-one in dup2
References: <52437121.1070507@redhat.com> <20131015140652.GA2098@ednor.casa.cgf.cx>
In-Reply-To: <20131015140652.GA2098@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2013-q4/txt/msg00001.txt.bz2

On 2013-10-15 09:06, Christopher Faylor wrote:
> On Wed, Sep 25, 2013 at 05:26:25PM -0600, Eric Blake wrote:
>> Solves the segfault here: http://cygwin.com/ml/cygwin/2013-09/msg00397.html
>> but does not address the fact that we are still screwy with regards to
>> rlimit.
>
> Sorry for the delay in responding.  I was investigating if setdtablesize
> should set an errno on error but it is difficult to say if it should
> since it seems not to be a POSIX or Linux.

Did you see <http://man7.org/linux/man-pages/man2/getdtablesize.2.html>?


Yaakov
