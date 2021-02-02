Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id D104C3971806
 for <cygwin-patches@cygwin.com>; Tue,  2 Feb 2021 09:44:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D104C3971806
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MIxqu-1lMsdw46Ly-00KORn for <cygwin-patches@cygwin.com>; Tue, 02 Feb 2021
 10:44:15 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 693CFA80520; Tue,  2 Feb 2021 10:44:14 +0100 (CET)
Date: Tue, 2 Feb 2021 10:44:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_serial.cc: MARK and SPACE parity for serial port
Message-ID: <20210202094414.GD4251@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAGEXLhUUtV-kKxO-jQo4427R=N=Uo1aT_LrHGpc1r55umbb92w@mail.gmail.com>
 <20210128100802.GW4393@calimero.vinschen.de>
 <20210128101429.GX4393@calimero.vinschen.de>
 <4d88d636-8274-5dea-67f8-f224a63b49a9@gmail.com>
 <20210201094009.GD375565@calimero.vinschen.de>
 <ff9e2845-7a5c-945c-f742-a79d65ab5909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff9e2845-7a5c-945c-f742-a79d65ab5909@gmail.com>
X-Provags-ID: V03:K1:8jMs8GQIqfJ+obqOB27KC5kYhQwjVS5ly1+bqhZ5mkyGn3ajPUE
 kMq4jeRm5J+OpcHOm/vx1r3v5uXIShbxYDYSz8kUn67ZSfiTjAXZ+Q5qHH52WDFoedgkF54
 SUisSFVcDwTHuCQ9eCLnHS5GPyKPmIIZURmweyEzSKPm1K4xf8u6LCdfy068VyR8aH5gRR/
 5L37xjIhQ3H3Ht6M6/5bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U7zUm7Jr28E=:ddLNf5Z//7hlO1uj36+Z/S
 2ITEdPDVK6/iqys0zMHqiJdD5nwaLyZ9tgeAeE1DzCR0cNrryx218RG5k67J3sVGoMjFuBFRk
 jSZCDplGMGZEqjVSvuGgB6ssa7eFpWhRoKLwSl7kEuYhgnI/yml3DE2i00vmh6ihOUuC0esJR
 8uKlRfGVOb33n4CrTSYLsGIisUb8gNHeW4HEyRlR4ys9VrLlT9OsBFGYAzC4wBewVkOXskRo9
 HtBt8lsrG1ezCu4HgczbXQHKpWEP3bKjjJfslu3flH1EYo1Rn4jw8dYjJoI/+bxiKKEIRBo/F
 81AT1DhrgPfPUVV7MZ55zZz6T5toYVuTVTkpt14Kuux75LKA5TvKayy6AwYzc7BW2xuq6JoNs
 BrzwcryJJwU1JuyR8eD1BJwbF2rLlhmnq73AfxeXtaAiwu4p2zDnMXgL/5KRka/QBscMtnkoQ
 OHDqivlV6yF9Py8qYMJG56KoDu4vs+QDGlxzRMWUYST/3qM474LxfkSguydpalrSdM4UepDK8
 4w4EDvssOEK5di7IyU1JoY=
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
X-List-Received-Date: Tue, 02 Feb 2021 09:44:21 -0000

On Feb  1 22:26, Marek Smetana via Cygwin-patches wrote:
> I'm Sorry, this is my first patch using the mailing list.

No worries.  Patch pushed.


Thanks,
Corinna
