Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id ADB17385780B
 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020 12:05:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org ADB17385780B
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mv2l4-1kAdie31WK-00r3ry for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020
 14:05:48 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D0974A82BD5; Tue, 13 Oct 2020 14:05:47 +0200 (CEST)
Date: Tue, 13 Oct 2020 14:05:47 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: drop ambiguous-wide behaviour from Unicode CJK locales
Message-ID: <20201013120547.GK26704@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <dad43925-fa94-e993-7c9f-10229321c335@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dad43925-fa94-e993-7c9f-10229321c335@towo.net>
X-Provags-ID: V03:K1:oXGcoC9ViLSWPHBFBNpT8L/JVhYtJTL5ECn0HngmPnCpIX8T3bi
 orss9sEc32SGkcKZPdRXPeovX4IhSXweLC3+4NPJ97ywwPd60Jr0g6vVCSPsS8A0/fF7C4D
 uNE+4N9v/DzpIYn1wspCEjJ5ql2IDCK8GHxv4UejVNDbJ3sZ4YH3z6fJ4gsruzMOCQf02b3
 4QrFIfZnA+FQwIReFyodA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M65FGx+eMMY=:H6LXh/lw3b/ENMA/3BxfMs
 Xy8TdsCdSWN1YKwRA0bU/Ity+ghdZnP7KRCNYAcwyuq9vRaMsMKh5PIqIA2l67LfUcuceXSDN
 +r5nD+VxD00IqZpytJWl/xkI+/sBARW6DidQh/puc9cBoiTkNIv5azXD1NjJivXGVG9rxxIgl
 t1k95LEuStXpEVZ/zJd3e+f+0PqR08F5JWUH0avufJ4KzpNNX3uJnmxNm1jClayL/ygCu1EUa
 /ckS8HQ62wrhKpT7FoNViOL8MxjWEqYk+lHNH8TjXFGkUnEQk5YmDLw1Jgnjy7ztEVrrm67ZU
 NFuoJ+ak1bnBAwIOqQSSdV6LPYjoEjpNLyErAXj3c0VPMeeOFOS6Dux/zq8RXiEccSmsHbIxY
 jMddLRnHnhVIg8Zxckfc/8YYP/6FMPIdgGqqIhcZ1oxN/PGUyHEzU8Mxx+6IegPlHlq/HzSo7
 uT8Xopx6RdCRFedA8AOc/E3AugJlF872Pz/ejpoNNg7ASKbO8DYPyQIZfF7zR/oVP2lYtOSBd
 HOukOWZFlFj6kzorithbg/TgoD0UZgaSOyxuOi/cucqMEIUkr6Ecb6KoswpjtDXzNqNe0sAFJ
 DQMEkz1ZBHTQ05+aniPaKz5TdPG9pnilnr5v8l9ljE7n0LEt+S34mnTyFzUtpub2ae5lA6XYF
 dNDOhkSjrVPvOnq3Tr0qAGvaY1xtDQ4ooB4Lt3/K/jWuRTTw37fUPuFV4tFN578eiHBdcYVsj
 UAiZHRAY3YDWJftDA351Aj+Mr0H9U8W2WW8S/wow+ukrsimVJkfrKdNJhovAVDuFTAcfrLOtH
 e1ZzWSI9bPkmoQBEenQoBwPvoG25SkOWbRfuhjxzzmwBR363NYtZ13D3Az5vkrl5yLvfMpc/R
 6ypvkBDxWyILj/lDPTRQ==
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
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
X-List-Received-Date: Tue, 13 Oct 2020 12:05:52 -0000

On Oct  7 18:55, Thomas Wolff wrote:
> It seems that ambiguous-wide behaviour (i.e. double-width property for
> characters in the East Asian Ambiguous width category) for CJK locales with
> UTF-8 encoding is inconsistent with Linux locale definitions.
> The attached patch changes that. Characters like ─ ü æ are no longer wide in
> the following locales:
> ja_JP.utf8
> ko_KR.utf8
> zh_*.utf8
> but only in ja, ko, zh locales with legacy encoding. Explicit modifiers
> @cjkwide and @cjknarrow are not affected.
> Thomas

Pushed (but this should go to the newlib list in the first place).


Thanks,
Corinna
