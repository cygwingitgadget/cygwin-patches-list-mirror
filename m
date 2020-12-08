Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id E1A813858006
 for <cygwin-patches@cygwin.com>; Tue,  8 Dec 2020 09:47:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E1A813858006
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1q4e-1kkMfe1Pya-002HwC for <cygwin-patches@cygwin.com>; Tue, 08 Dec 2020
 10:47:34 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CBF4AA806E3; Tue,  8 Dec 2020 10:47:33 +0100 (CET)
Date: Tue, 8 Dec 2020 10:47:33 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Allow to set SO_PEERCRED zero (v2)
Message-ID: <20201208094733.GM5295@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201207102936.1527-1-mark@maxrnd.com>
 <20201207153025.GJ5295@calimero.vinschen.de>
 <20201207153513.GK5295@calimero.vinschen.de>
 <0dffe28e-1b11-3637-ade1-c005a554ce50@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0dffe28e-1b11-3637-ade1-c005a554ce50@maxrnd.com>
X-Provags-ID: V03:K1:oeOLY7sN1RPWmf3JSbjdlvQAfwQvv2wYsUSBpVrXYEiflS9UjM/
 8O8JFOko1/PbEiikhXifzguEwu5HsvkVf44ylyiSeqjyMsctb+zGvs5Bh5poWKWdl7jBYMN
 PE9CNiL2oliFdHmkeUcSHFBfi0vBZyyNnNIkjL0TyvdFBbdoGJwd3A+f77dAROFFLvqZKCE
 T6iyxnKwRAOLfM7IQ+ydQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tVrjJMTYsS8=:zMYIz/6yYMMdYvcXVLIJDC
 bjwJsHFjv0W6ueIeczmogDWx0ilhuawD+28ZybaX9Ysbc/Ajsu6PP+u+D936Z5653m2aJdVzX
 3xy3IniaJdzLWCLUE+TDj2si1IRq1OdPS85lA4w29MyVjDZhhgFL4v4gAJnB4RKGAJPSul1sA
 gvbySsHV9KhRojg4oMRr4i+GruBi8wXfthFWCRihgul323YCMZ9RxGOKb08xPPmyUYWi62epa
 cpVNjJQ3Kpbbpnuutks8/pwKk11pNNLZp05ruUz5fuO97/f3YwvVOnM6tNkBtDFzuCHM7Bzoi
 4ZYDWhpvE2odiQLSWLb02PBpymhKnXxTZKQcHEJjUzQb3wWNO9OOgqD11XV7/OWlrT2MXX4oY
 CqTL/HbVKUBSww/A+52Y8nlc28vzfxl3sjf1w8SAT/o8IGWlmIBWiNLEIiXFU2/PBp9cSUcyn
 0cfhhu9GrA==
X-Spam-Status: No, score=-100.7 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Tue, 08 Dec 2020 09:47:37 -0000

Hi Mark,

On Dec  7 19:25, Mark Geisert wrote:
> Hi Corinna,
> 
> Corinna Vinschen via Cygwin-patches wrote:
> > On Dec  7 16:30, Corinna Vinschen via Cygwin-patches wrote:
> > > On Dec  7 02:29, Mark Geisert wrote:
> > > > The existing code errors as EINVAL any attempt to set a value for
> > > > SO_PEERCRED via setsockopt() on an AF_UNIX/AF_LOCAL socket.  But to
> > > > enable the workaround set_no_getpeereid behavior for Python one has
> > > > to be able to set SO_PEERCRED to zero.  Ergo, this patch.  Python has
> > > > no way to specify a NULL pointer for 'optval'.
> > > > 
> > > > This v2 of patch allows the original working (i.e., allow NULL,0 for
> > > > optval,optlen to mean turn off SO_PEERCRED) in addition to the new
> > > > working described above.  The sense of the 'if' stmt is reversed for
> > > > readability.
> > > > 
> > > > ---
> [...]
> > > > -- 
> > > > 2.29.2
> > > 
> > > Pushed
> > 
> > I created new developer snapshots for testing.
> 
> I didn't phrase my comment somewhere about "future snapshot TBA" as I had
> intended.  I just meant some future snapshot, not that I was requesting one
> for this patch.  But thank you very much anyway.

I freely admit I didn't actually read your comment :}

I just created this snapshot because it seemed useful, so all is well :)


Corinna
