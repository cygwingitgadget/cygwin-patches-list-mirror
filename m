Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id ECA5B385480D
 for <cygwin-patches@cygwin.com>; Fri,  4 Dec 2020 12:09:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org ECA5B385480D
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MEFrX-1kvIMm0GKD-00AHGh for <cygwin-patches@cygwin.com>; Fri, 04 Dec 2020
 13:09:05 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 71FF2A80671; Fri,  4 Dec 2020 13:09:04 +0100 (CET)
Date: Fri, 4 Dec 2020 13:09:04 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/2] proc(5) man page
Message-ID: <20201204120904.GA5295@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201125064931.17081-1-Brian.Inglis@SystematicSW.ab.ca>
 <20201130104755.GE303847@calimero.vinschen.de>
 <f6be8646-4e4c-9133-f9ac-00a89a437aad@SystematicSw.ab.ca>
 <20201201095554.GK303847@calimero.vinschen.de>
 <48e990d4-f527-1eb1-f2ce-6fc0e594c99d@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48e990d4-f527-1eb1-f2ce-6fc0e594c99d@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:8imE/A2xT18FchajkKowAeJJQZk0XwWoy16g52zM1LoJm4peiA8
 H1mps8gRfwpG0zBjSv2T3Yy177X72AbgBzWfotkkybnT5UM0hAFEs9/skNeefXv3YEqG72b
 yEIA4iCPUKTst1UTOFyaKW81KtFu0CcQn3qVJLLu/uXcdgde09StlVaghy/DL0CdSDNh5hR
 V3gvy7kDPu5bGyl/rg4/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TCm5i9SPTOs=:MyDOXFwV/4nkLJ175Rog4T
 v3TbfShCFRetq0aISIdbhYimeb1wD6MJvGqtIkxSMeZaa8gR+Cvj+UxgLA1WiztSAuMsAaEN7
 gs/Wwv6ZVZA0G7VkhzHieWqwcwdKVvpifhjtc9mbt9iJSo2mCDYSxBL+iS6a2aJ0u5qFYSMzz
 ca4U9cokD+0XMtP1mCHjx7XpgNdld0MrMi4gX63kgeSEf291vZ6+SeDkkr/drb3f/Cz2h4j38
 5u9h2huoCFEZYI+dMOLjAHtRFr8KVpnLZ5COtPDzf+Wvv/mErKKR4/ZO0/osgZtjTpUkWASxv
 70fKQIN7f/iqJDi+upqrViIo2rouGGB3AhbIGRs8f8HGW+um+J3eoYC3Wg5wMr5gz9YlYaYNP
 pw2xjkptMphU7fZ+wiLHk3FRziKfR9LFy2fcrDTlekUf8dhDWKiHV3vS2jdEg+uwhhCvpsy8K
 IT4Wv+D6Fw==
X-Spam-Status: No, score=-100.4 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Fri, 04 Dec 2020 12:09:08 -0000

On Dec  1 09:49, Brian Inglis wrote:
> On 2020-12-01 02:55, Corinna Vinschen wrote:
> > On Nov 30 17:57, Brian Inglis wrote:
> > > On 2020-11-30 03:47, Corinna Vinschen wrote:
> > > > On Nov 24 23:49, Brian Inglis wrote:
> > > > > Brian Inglis (2):
> > > > >     specialnames.xml: add proc(5) Cygwin man page
> > > > >     winsup/doc/Makefile.in: create man5 dir and install generated proc.5
> > > > > 
> > > > >    winsup/doc/Makefile.in      |    4 +
> > > > >    winsup/doc/specialnames.xml | 2094 +++++++++++++++++++++++++++++++++++
> > > > >    2 files changed, 2098 insertions(+)
> > > 
> > > > It would be helpful if you could outline the changes from v1.
> > > 
> > > Those were fairly minor fixes to content and some processing outlined in the
> > > (lengthy) responses to Jon's (lengthy) comments under:
> > > https://sourceware.org/pipermail/cygwin-patches/2020q4/010829.html
> > > 
> > > and I have copied them below, so please clarify if the below is not what you want?
> > 
> > I was after a short list with bullet points, ratehr than copying
> > an email I have in my inbox anyway :}
> > 
> > Jon, can you please take another look, too?
> 
> * patches are sent directly from git send-email
> * trailing whitespace only in Makefile.in context lines so left as is
> * comment changed to "based on" Linux manpages project proc(5)
> * dates retained to show how current content is, rather than when last built
> * /proc/loadavg 'D' state mention removed
> * /proc/registry Windows changed to Cygwin to clarify this variation
> * /proc/version kernel changed to Cygwin
> * Notes subsection missing title and Copyright subsection not included in
> standalone man page due to Colophon subsection messing up man rendering
> * removed Colophon subsection and Notes reappears properly and Copyright is
> included; other system show these under Notes except RH uses Caveats
> * retain remap attributes as Docbook rendering hints
> 
> -- 
> Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
> 
> This email may be disturbing to some readers as it contains
> too much technical detail. Reader discretion is advised.
> [Data in binary units and prefixes, physical quantities in SI.]

Thanks, pushed.


Corinna
