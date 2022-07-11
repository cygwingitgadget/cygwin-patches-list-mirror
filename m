Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 4570D3858292
 for <cygwin-patches@cygwin.com>; Mon, 11 Jul 2022 07:45:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4570D3858292
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MC2sH-1oIGlF3PvJ-00CTw4 for <cygwin-patches@cygwin.com>; Mon, 11 Jul 2022
 09:45:16 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id ED582A80751; Mon, 11 Jul 2022 09:45:15 +0200 (CEST)
Date: Mon, 11 Jul 2022 09:45:15 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Update FAQs which are out of date on the details of
 setup UI
Message-ID: <YsvVC4qwC9Lao/Ho@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220707114428.65374-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220707114428.65374-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:g+EFdeKdenfA+7vEj4HLnp0fxdTcW7liij0m7KI+4+p310eBdep
 SaAysIDLXM3QLKBsyWQzHtcPwyqDKnm7T0pM5lxtdLB1OzKdCuFV3c8K3JLhx8/KBH5paLz
 8zcLGwPwdPj+cpHGMmkXUvDzO6TCtsGlidDaiHroD3Xas9MiLZdNcgH2AFf3LgXZH10XgbL
 A6f4zCzNAEYMyMEB68BaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9/YrkOtWfLk=:u8uLgC7OjrUj5cDp99xhx/
 H04ZlxZUXP8RfmP8BaPwpIYLB5syJHTAALNZwGrlJjgEw3s1Df0fSS3Qiv/VljyOtl4z/W+YY
 M2k3U1Sz0cshIxo3XUU+zP57BaxJFPTVmQjkH2LGJWzsF0AfYMLun2z4JBkwSjBGxJ58nYgQq
 fwnJK2EX/i7kJQv4i8c6C/MbXs5W59LeXnM/Ht81T6Z5p5Vm0nJ3Fq4yVjYIvEmAoKJNyvzWm
 uC4veOJvZ99sIghVH72qdTmMIrZcK3lUghgWpoc+WQ5wFy8UF6THxTv9P2yFBurz7VrmcTu/O
 wJf/vztID+OG/S80nEdkGKXvJMdSAjD6ZePs1DNFIaSIoOX78u7gLNq71XSFZHvgDzlS//unQ
 0KSfbLT+Aja3VBJ5KGD9flZx+FGt83UIN9TpL91uWZUKjbBJ7qFY8AtHBTuoRTVXkWsyBwyDW
 jOdWQHPC3AtA/x7tTebq1CycZQO0p28fZrszPa1sLYuggs/KwPYBvw/jVLXWtKe2imT8MNixj
 XmL0EJjtxRIrNxTv6jRs8RCIepiZNOYNGSU1exG3G3cBhKkE6SplY5KgcbygVvWP2VBqD6xz2
 6Ic3kYN+7QcuDJGM/lgd/e32A7PvbR8dcj+qXm9DlI+QPErW/AInvqYQn4N1rSEETnvA+nNHy
 fYAZo4Qmq5yEJJd3taw4QZmV+g7LTLS+WQ3VEpx97rZ0xToc2lweB5GAVdbzxz/0Rf5gvxuyd
 EQ/wilHeWmbL3rQkX+OWrTVMXADf3Iw82NM/AKlB9x53bS9LwDX9X1c/8B8=
X-Spam-Status: No, score=-95.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
X-List-Received-Date: Mon, 11 Jul 2022 07:45:21 -0000

On Jul  7 12:44, Jon Turney wrote:
> ---
>  winsup/doc/faq-setup.xml | 11 ++++++-----
>  winsup/doc/faq-using.xml | 14 +++++++-------
>  2 files changed, 13 insertions(+), 12 deletions(-)

LGTM

Thx,
Corinna
