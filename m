Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-046.btinternet.com (mailomta25-re.btinternet.com
 [213.120.69.118])
 by sourceware.org (Postfix) with ESMTPS id A1DD23858C51
 for <cygwin-patches@cygwin.com>; Thu, 28 Jul 2022 16:43:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A1DD23858C51
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-046.btinternet.com with ESMTP id
 <20220728164259.VKXE3123.re-prd-fep-046.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Thu, 28 Jul 2022 17:42:59 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613A8DE8318891A3
X-Originating-IP: [86.140.69.48]
X-OWM-Source-IP: 86.140.69.48 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduhedggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpefhueeileegudejteeikeevkedvtdduvdfhhfeltddugeefjeeuffeljefhvdduteenucffohhmrghinheptgihghifihhnrdgtohhmpdhsrghmsggrrdhorhhgpdhgnhhurdhorhhgpdhsohhurhgtvgifrghrvgdrohhrghenucfkphepkeeirddugedtrdeiledrgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdehngdpihhnvghtpeekiedrudegtddrieelrdegkedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepuehrihgrnhdrkfhnghhlihhssefuhihsthgvmhgrthhitgfufidrrggsrdgtrgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.105] (86.140.69.48) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613A8DE8318891A3; Thu, 28 Jul 2022 17:42:59 +0100
Message-ID: <a6958727-80ee-d8a3-3925-470c7f839a59@dronecode.org.uk>
Date: Thu, 28 Jul 2022 17:42:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Update FAQs which are out of date on the details of setup
 UI
Content-Language: en-GB
To: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220707114428.65374-1-jon.turney@dronecode.org.uk>
 <YsvVC4qwC9Lao/Ho@calimero.vinschen.de>
 <91d1d17c-27d2-a271-a9b6-bcd3811084ca@SystematicSw.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <91d1d17c-27d2-a271-a9b6-bcd3811084ca@SystematicSw.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.6 required=5.0 tests=BAYES_00, BODY_8BITS,
 FORGED_SPF_HELO, GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY,
 KAM_SHORT, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 28 Jul 2022 16:43:02 -0000

On 23/07/2022 21:46, Brian Inglis wrote:
> On 2022-07-11 01:45, Corinna Vinschen wrote:
>> On Jul  7 12:44, Jon Turney wrote:
>>> ---
>>>   winsup/doc/faq-setup.xml | 11 ++++++-----
>>>   winsup/doc/faq-using.xml | 14 +++++++-------
>>>   2 files changed, 13 insertions(+), 12 deletions(-)
>> LGTM
> 
> [original did not make it to me; caught up on archive and noticed]
> 
> URL duplicates .html:
> 
>      <ulink url="https://cygwin.com/package-server.html.html">
> 
> should perhaps also have the self-closing tag delimiter "/>":
> 
>      <ulink url="https://cygwin.com/package-server.html" />
> 
> where the extra space ensures it is also valid XHTML/XML so it can be 
> checked or processed with better tools that can catch issues ;^>
> 
> [attachment extract]
> 
> diff --git a/winsup/doc/faq-setup.xml b/winsup/doc/faq-setup.xml
> index ce1069616..da9fce534 100644
> --- a/winsup/doc/faq-setup.xml
> +++ b/winsup/doc/faq-setup.xml
> ...
> @@ -688,7 +689,7 @@ files, reinstall the "<literal>cygwin</literal>" 
> package using the Cygwin Setup
>   this purpose.  See <ulink url="http://rsync.samba.org/"/>,
>   <ulink url="http://www.gnu.org/software/wget/"/> for utilities that 
> can do this for you.
>   For more information on setting up a custom Cygwin package server, see
> -the <ulink url="https://sourceware.org/cygwin-apps/setup.html">Cygwin 
> Setup program page</ulink>.
> +the <ulink url="https://cygwin.com/package-server.html.html">Cygwin 
> Package Server page</ulink>.

I am confused.

The <ulink> tag is closed by the </ulink> tag later on the same line, 
after enclosing the link text 'Cygwin Package Server page'

> 
>   </para>
>   </answer></qandaentry>
> ...
