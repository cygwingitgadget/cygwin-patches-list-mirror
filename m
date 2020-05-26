Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-044.btinternet.com (mailomta23-re.btinternet.com
 [213.120.69.116])
 by sourceware.org (Postfix) with ESMTPS id 89AD2388B01D
 for <cygwin-patches@cygwin.com>; Tue, 26 May 2020 15:11:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 89AD2388B01D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-044.btinternet.com with ESMTP id
 <20200526151104.HUUM4009.re-prd-fep-044.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Tue, 26 May 2020 16:11:04 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [86.159.36.222]
X-OWM-Source-IP: 86.159.36.222 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedruddvvddgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeguefhkedvfeeigefhhedtjeehieegtdehhffhheffgfehheegtdffleejteeuueenucfkphepkeeirdduheelrdefiedrvddvvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddujegnpdhinhgvthepkeeirdduheelrdefiedrvddvvddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeomhgrrhhksehmrgigrhhnugdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.117] (86.159.36.222) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5E3A15B61295832B; Tue, 26 May 2020 16:11:04 +0100
Subject: Re: [PATCH 1/3 v3] Cygwin: tzcode resync: basics
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200522093253.995-1-mark@maxrnd.com>
 <20200522093253.995-2-mark@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <857ad727-00df-e948-c823-f47448a47fec@dronecode.org.uk>
Date: Tue, 26 May 2020 16:11:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522093253.995-2-mark@maxrnd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 26 May 2020 15:11:07 -0000

On 22/05/2020 10:32, Mark Geisert wrote:
> 
> diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
> index f273ba793..2ac8bcbd8 100644
> --- a/winsup/cygwin/Makefile.in
> +++ b/winsup/cygwin/Makefile.in
> @@ -27,7 +27,7 @@ export CCWRAP_HEADERS:=. ${srcdir}
>   export CCWRAP_SYSTEM_HEADERS:=@cygwin_headers@ @newlib_headers@
>   export CCWRAP_DIRAFTER_HEADERS:=@windows_headers@
>   
> -VPATH+=$(srcdir)/regex $(srcdir)/lib $(srcdir)/libc $(srcdir)/math
> +VPATH+=$(srcdir)/regex $(srcdir)/lib $(srcdir)/libc $(srcdir)/math $(srcdir)/tzcode
>   
>   target_cpu:=@target_cpu@
>   target_alias:=@target_alias@
> @@ -246,6 +246,15 @@ MATH_OFILES:= \
>   	tgammal.o \
>   	truncl.o
>   
> +TZCODE_OFILES:=localtime.o
> +
> +localtime.o: $(srcdir)/tzcode/localtime.cc $(srcdir)/tzcode/localtime.c.patch
> +	(cd $(srcdir)/tzcode && \
> +		patch -u -o localtime.c.patched localtime.c localtime.c.patch)
> +	$(CXX) ${CXXFLAGS} ${localtime_CFLAGS} \
> +		-I$(target_builddir)/winsup/cygwin \
> +		-I$(srcdir) -I$(srcdir)/tzcode -c -o $@ $<
> +
>   DLL_OFILES:= \

This adds 'patch' to the build-time requirements of Cygwin, which should 
probably be noted in the answer to faq.programming.building-cygwin in 
winsup/doc/faq-programming.xml.

(There's also some stuff in there about LSAs requirements which is 
stale, I think?)

