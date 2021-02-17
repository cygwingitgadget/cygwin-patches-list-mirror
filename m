Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 60F273894430
 for <cygwin-patches@cygwin.com>; Wed, 17 Feb 2021 09:29:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 60F273894430
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Ml6Zo-1lZFMF0pn2-00lVaj; Wed, 17 Feb 2021 10:29:31 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 57030A805CE; Wed, 17 Feb 2021 10:29:30 +0100 (CET)
Date: Wed, 17 Feb 2021 10:29:30 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH v2] winsup/doc/posix.xml: add note for getrlimit,
 setrlimit, xrefs to notes
Message-ID: <YCzh+lCePeSgiRqf@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
 Jon TURNEY <jon.turney@dronecode.org.uk>
References: <20210215223540.18256-1-Brian.Inglis@SystematicSW.ab.ca>
 <YCus7LynfyqkvjWl@calimero.vinschen.de>
 <39425336-2abc-793e-f2fd-ac6ade12d55c@SystematicSw.ab.ca>
 <ac3a2eb5-2d56-c1ba-cd53-adf8adc41b07@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac3a2eb5-2d56-c1ba-cd53-adf8adc41b07@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:eMrA0jxzHZKeE1KqMZzeNCChX0A6YTXpEZMP1BVV2lZcuSp+3ME
 OO95jYon/P1l4ZZNt/dxksl3jvDlBa2zdjwXPvTlfrqKwPZ3+ETaY7HK9cll3F1RvxEscpG
 K0Wn/mxDyQm+gAOLf4BzNydodv2MiiK3ApBh+M02Oc8uV8Fsng/5nxZKAJKHo8WY8R42KxB
 vv+chrjjhA9rAeSeI1DTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+CsC2fQx3dg=:4DMWLQ9uwXP4eFQqWVGYbA
 rrRgtXss7OAtbnaRz6cbRxN1I1KtzvtUm3dI1kkX8wJWC5xEUgGWMB0gVihsnf0TqGGhbbtRd
 XNSmsms3RxpPBnDZkzunc51DxxKCLI5SQVAm1E/alSU/27jw3Ovff2LtH71BOpcj8RlskRqEW
 V1yeMFRnC9UxlpKamPCi+jlJwCBdiCI7BXPZ+1+p30NLy9xJ54anVPVQ/fqRPB/cArS/bcbwE
 8xw2wBoB+lBw3C7OK7k92lfvIzpEmAdnrlRh61JDPk4Fm/+HXHiLtdk9xoD92snFByjz+b3e9
 l3a6mLN/vTftu/s+JOPsmZIr54U698PQq77bZSSepFQBHjLtPD2PtPca9uVWaUz+uIL+xjW9M
 JimbiusP0RZ/WFCjhWI/7k3Mke8qpCQ9TVB7+0MmboiRvrpXHXw9hiA4cAYyjB+6rExAktM0p
 c/cKmo97mQ==
X-Spam-Status: No, score=-101.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Wed, 17 Feb 2021 09:29:36 -0000

On Feb 16 10:00, Brian Inglis wrote:
> On 2021-02-16 09:51, Brian Inglis wrote:
> > On 2021-02-16 04:30, Corinna Vinschen via Cygwin-patches wrote:
> > > On Feb 15 15:35, Brian Inglis wrote:
> > > > change notes to see "Implementation Notes" to xref to std-notes;
> > > > add xref to std-notes to getrlimit, setrlimit;
> > > > add note to document limitations of getrlimit, setrlimit resources support
> > > > ---
> > > >   winsup/doc/posix.xml | 101 ++++++++++++++++++++++++-------------------
> > > >   1 file changed, 57 insertions(+), 44 deletions(-)
> > 
> > > Pushed with a change:
> > >    <xref linkend="std-notes">(see chapter "Implementation Notes")</xref>
> > > -->
> > >    (see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
> > > The reason is how xref is handled when creating html docs.  The result
> > > of an xref is always 'the section called "..."'.  With the above change,
> > > the text works (albeit differently) in html and info file.
> > 
> > Cheers, thanks, I'll bear that in mind in future, and read the generated
> > output more carefully.
> > 
> > I'm not seeing .info generated with Note:... links, is that okay?

db2x_docbook2texi from docbook2X is used for that.

> > Also ...api.pdf is no longer being regenerated, so what have I lost or am missing?

xmlto is doing this stuff, maybe the pdf option requires another package?

> > I have the following doc tools (and others):
> > 
> > $ apt l asciidoc dblatex poppler\$ xmlto
> > asciidoc 8.6.9-1 x86_64 [installed, manual]
> > dblatex 0.3.10-1 x86_64 [installed, automatic]
> > poppler 21.01.0-1 x86_64 [installed, manual]
> > xmlto 0.0.28-1 x86_64 [installed, automatic]
> 
> Also as documented plus other dependencies:
> 
> $ apt l build-docbook-catalog docbook-sgml45 docbook-utils docbook-xml45 \
> 	docbook-xsl docbook2X
> build-docbook-catalog 1.5-2 x86_64 [installed, automatic]
> docbook-sgml45 4.5-1 x86_64 [installed, automatic]
> docbook-utils 0.6.14-2 x86_64 [installed, manual]
> docbook-xml45 4.5-1 x86_64 [installed, manual]
> docbook-xsl 1.77.1-1 x86_64 [installed, automatic]
> docbook2X 0.8.8-1 x86_64 [installed, manual]
> 
> > What else is needed?

Good question.  I'm running that on Fedora with the following docbook
packages installed:

  docbook-dtds
  docbook-style-xsl
  docbook-style-dsssl
  docbook-utils
  docbook2X

xmlto adds a dependency to flex.  docbook2X depends on texinfo, texinfo
comes with a number of packages on the far side of infinity.

Jon?  Any idea?


Thanks,
Corinna
