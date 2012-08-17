Return-Path: <cygwin-patches-return-7708-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7511 invoked by alias); 17 Aug 2012 13:05:42 -0000
Received: (qmail 7309 invoked by uid 22791); 17 Aug 2012 13:05:39 -0000
X-SWARE-Spam-Status: No, hits=-3.3 required=5.0	tests=AWL,BAYES_00,KHOP_THREADED,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.17.10)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 17 Aug 2012 13:05:25 +0000
Received: from [10.255.169.154] ([62.159.77.186])	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)	id 0McPxo-1TJt7j2uMS-00IHkW; Fri, 17 Aug 2012 15:05:23 +0200
Message-ID: <502E4188.6000605@towo.net>
Date: Fri, 17 Aug 2012 13:05:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: /dev/clipboard pasting with small read() buffer
References: <502ABB77.2080502@towo.net> <20120816093334.GB20051@calimero.vinschen.de> <502CE384.8050709@towo.net> <20120816123033.GH17546@calimero.vinschen.de> <502D0199.6040203@towo.net> <502D10AF.1040501@redhat.com> <20120816162245.GC14163@calimero.vinschen.de> <502E0451.3020609@towo.net> <20120817092239.GA11017@calimero.vinschen.de>
In-Reply-To: <20120817092239.GA11017@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00029.txt.bz2

On 17.08.2012 11:22, Corinna Vinschen wrote:
> ...
>>   Anyway, my updated patch (using MB_LEN_MAX) proposes a change here as well.
> Thanks.  I dropped the hint that 4 is enough.  I'm not so sure about
> that.  Linux, for instance, defines MB_LEN_MAX as 16.
SunOS defines it as 5. 
http://www.kernel.org/doc/man-pages/online/pages/man3/MB_LEN_MAX.3.html 
says in glibc it is typically 6 (which would be needed for original 
UTF-8 covering 31-bit ISO-10646).

> Other than that, patch applied.
Thanks
Thomas
