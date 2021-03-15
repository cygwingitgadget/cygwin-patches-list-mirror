Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id E0BC73857C44
 for <cygwin-patches@cygwin.com>; Mon, 15 Mar 2021 10:17:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E0BC73857C44
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MZTa2-1lFi8u1TOw-00WSfR for <cygwin-patches@cygwin.com>; Mon, 15 Mar 2021
 11:17:42 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id EC8A2A80D7C; Mon, 15 Mar 2021 11:17:41 +0100 (CET)
Date: Mon, 15 Mar 2021 11:17:41 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Treat Windows Store's "app execution aliases" as
 symbolic links
Message-ID: <YE80RYZOoTSYxJbs@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
 <ff661784-ae78-4a98-8f6d-cddd57b0d216@pismotec.com>
 <nycvar.QRO.7.76.6.2103140115180.50@tvgsbejvaqbjf.bet>
 <86c7c1b6-06f9-9e60-e9d7-072b6e8c806f@pismotec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86c7c1b6-06f9-9e60-e9d7-072b6e8c806f@pismotec.com>
X-Provags-ID: V03:K1:MYr2TqxH2pUbkyNEYMDMS16tgdtTvMfSGiz10UGAsXOOCdU4Ril
 QRoXZQYCT1QFT0s3Hx6Eld7U0M9OHaAH4vuroKw1eKkKlfRJIbRM8KzqX03jXj1XEHiKNSG
 s1Q//rjsD9bAxAimlJq1dEonPMdafQvoyv7/6ORZdyF0on+7/cAJGV2JEy+bk76T8Y/PoqK
 REg2VuoAsFoHUQC6CoVqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PzWlGEqUEFo=:cWxxO3LujMubjMSe27RMMm
 caANIbajU4FXk/kwtmEnjJTAoCFJvNR0ZkyLXIDcwiBhVaEj2y3sPYTaKBt0AnCQACY6o9iYx
 +l6FcPnmskQjkkRInKllr3ET+Mt2JwEeVhwbXr2Xg1Go5CPlEPln1mqO2ywewXe7QpZWMUleK
 VoGlZ4k98NyfKSRPcTzEf5BeoXT4dhRn8XD5P2dGZ13YXE8DfrHwx4LuvVC23cVBYN0zp6Nvr
 CYgA70fF8HfkskUKGnn+YwWn0Zumn9vvGxF14dK/G5KXsy2ONzajeLdKe8hdwSBfdu+rCYeGp
 63a/Iv1+V2tV7QYAO+eo1VDFAiCEgIZG8wqu7CcFa6REAO+eE7toE10FOs4Wv9DdAUopC9YyD
 zp7p1hQ387nbmSbtWvPMryKVQo6ZBTC5/gmPjDqV1yNsoF63tkYd6ElBr5pFRSRS31cf9BHpm
 fQrUAs0moQ==
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 15 Mar 2021 10:17:45 -0000

On Mar 13 19:41, Joe Lowe via Cygwin-patches wrote:
> Hi Johannes,
> 
> I agree on the usefulness to the user of showing appexec target executable
> as symlink target. But I am uncertain about the effect on code.
> 
> One example: Any app that is able to archive/copy posix symlinks will
> convert the appexec to a symlink and silently drop the appexec data. Whether
> this is a significant issue depends on if most/all relevent store apps
> function the same when the executable is exec-ed directly vs via the appexec
> link.

You won't get a sufficent, POSIX-like handling one way or the other.
Handling them as files will not allow correct archiving either, because
the reparse point data required to restore them correctly to work in
Windows won't be archived anyway.  There's only so much we can do in the
Windows environment.  ¯\_(ツ)_/¯

I'd just like to postpone this patch to get 3.2.0 out.  I'll add that
patch to the inevitable 3.2.1 release, given the massive testing of
3.2.0-0.1 on the Cygwin ML...


Thanks,
Corinna
