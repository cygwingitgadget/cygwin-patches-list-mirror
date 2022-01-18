Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id CCA183858D39
 for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022 10:50:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CCA183858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N3sZy-1mA8zK1eoi-00zpwY for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022
 11:50:18 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id DC016A8096F; Tue, 18 Jan 2022 11:50:17 +0100 (CET)
Date: Tue, 18 Jan 2022 11:50:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: resolver //Was: [PATCH 3/7] Debug output to show both IP and
 port # in native b.o., a few little cosmetic improvements for consistency
Message-ID: <YeabaaciPOzsMUBp@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DM8PR09MB70952595CA9E93D575F033F9A5579@DM8PR09MB7095.namprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR09MB70952595CA9E93D575F033F9A5579@DM8PR09MB7095.namprd09.prod.outlook.com>
X-Provags-ID: V03:K1:m9m/e8wiy8CPxX2LiXEkVTNaegV0kOTMksM9DTOEZVglf+7hZKq
 LFEQH63rzd9RkfnL6Q0sxH7SJF+65LzCbZw5K5zZQBFWp+lvfSYu0fdTuaeXbDwYp9bBXEw
 iYAegRNHJPSDoLXpyOM9q2I6p4wi57+4KN7/vRmnk5Zh9JfBoT46aUCOcivlCTvjVh+4Lpl
 3JzvcjXUyPituMDx+RPGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gdOw93SpNVQ=:jTyPyS1B6ere7jGXMIlZtv
 5KzTLDYHXfQ+JJW6fP5tTHfsCCFLRP2g1rtcQffQpUiXH+cUIZpnTXQ7C7ubyI1C7MtKg6sK9
 Y5StrEQJRWX1deq5a1p/CDXR2QypT4sZEs3Cs4IxluacXz2xoU4vLzPlURMFmg5RL2rDFZ9LW
 kPdNpRkAmzSFmb4G3G/HFHUwepAYdTfUqezSFSfFFcafVWm1fYAXJUz+SecESJwVsCgqtvG0y
 COguycopt+sm2EzCT2qi6Nk/3yN21+AfBzU6SyqM87wLDEsAg3OfuWaj/ru+VEJt692FhR/J9
 fd52qn553y8ZdQVLQUAoC2I2KRd70UPQTY58fZjV+26daGbiEGhSFO0oAUsDDV7FHQxxvYe+N
 Qo8g8rpIdk26cXwr4DN3cQTnnXWc55XQLj2aaIEm3HOE6+6dwht0u72+tesrqjStokQM5AIoU
 7M0S/FR4hl2w8jvJ+41ODXYIQym3fAAI4JirYFJlX7JAmmAYFU6IpyJoftlFLSuG9pXPbJn8d
 uyifPQEd491KEcH6OYBF7T4yBBi5iTJQraBDv5MfmRj5GT0XmAsJLNhxYYkqOsMMsropdcmhB
 cjXaIdcfKlH5D3b8hkN8UXzZB7lQ5pJk5GMTdqKmGdV/jkimzxxa+gBlpm/aUvvb5H0d4tsuS
 h57cCjDb3p/dpHbh7sce0Nb+oHByNGiLsL1DtQQ6FatopquwtgjnCzWzjH80JszLLGn4MLoE3
 1+WyQKpGyxIxc72W
X-Spam-Status: No, score=-96.5 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Tue, 18 Jan 2022 10:50:21 -0000

Hi Anton,

On Jan 17 18:29, Lavrentiev, Anton (NIH/NLM/NCBI) [C] via Cygwin-patches wrote:
> Hi Corinna,
> 
> > Other than that, the remaining patches look good, except, adding a short
> > description what patch 7 does to the commit message would be great for
> > later readers of the git log.
> 
> I resubmitted the patches with a little improvement and a better description
> to the #7 (now #5) as requested.

Thanks!

> While doing the code review afresh in there, I noticed a few more problems:
> 
> 1.
> minires-os-if.c on line 262 does this:
>     262         ptr = NULL;
>     263         break;
> 
> and then a bit later this:
>     290   len = ptr - AnsPtr;
> 
> which makes the return value "len" to be a total nonsense (I think it
> should return -1 in this case, but it's debatable).

I don't think it's actually debatable.  The statp->os_query call should
return the same kind of reply as the calling res_nsend/res_nquery.  The
return values of this function calls are used unfiltered.  Therefore
the above snippet needs fixing and, along the same lines, it should
set statp->res_h_errno to a useful value.

> 2.
> Also, "ptr" in the cygwin_query() function is not checked for buffer
> overrun in the "done:" section of the code (after line 291), which is
> not good IMO.

ACK

> 3.
> Lastly, at other places where "ptr" is checked for overrun (notably,
> in write_record()), it can leave garbage in the unfilled portion of
> the answer buffer (because it still advances "ptr" properly, to
> calculate the final "would-be" size of the response): so if the return
> value is greater than the passed "AnsLength", the user cannot assume
> that at least all AnsLength bytes were filled correctly.  They cannot
> actually assume any "boundary" where the "Ans" buffer was actually
> stopped being updated.
> 
> Maybe "Ans" should be cleared upon entry?... But that would mean
> double-write of the buffer in most of the use-cases (where no overflow
> actually occurs because of an adequate size of the buffer).

Either that or fill the reminder of the buffer with 0-bytes.  Clearing
upon entry is a simpe and good choice, IMHO.  Yeah, it might take
a tiny little bit longer, but it's a safe choice.

Thanks for looking into this!
Corinna
