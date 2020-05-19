Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id A4B70389201F
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 09:48:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A4B70389201F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNOZO-1jPVS90slW-00OqLw for <cygwin-patches@cygwin.com>; Tue, 19 May 2020
 11:48:31 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CDAF2A80F7E; Tue, 19 May 2020 11:48:30 +0200 (CEST)
Date: Tue, 19 May 2020 11:48:30 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Re [Cygwin PATCH */9] tzcode resync -- for discussion only
Message-ID: <20200519094830.GQ3947@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.BSF.4.63.2005131531040.41959@m0.truegem.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.2005131531040.41959@m0.truegem.net>
X-Provags-ID: V03:K1:mjQwAVOMRlU0MSpMbhwURNIc4gmCBFnn0wpYjWQunzpyLBuI6Z2
 4PsnTxLDw8s68fZMzGS1kzvl68uoC2n+F3obTnvSYTgzthvYBZk8fFdrNWkDzbwDWo+yBgi
 fSjLYuqjHDvpAiWuguMl4DjoVoEk6sTGmevaMUBhSfrx7uP1VobkMDYmSGh71jj8SnXQxGD
 JiW/jPhpgD7lliAtzVg1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wwkCsszssgA=:9M1hv0PeCWtKvtksAzssvc
 m7by91/eExxFW3McBhUVBU1UGSeI1ajmS0GjxFcsT2DqrjBcAiS99e8kUhqfcNk4otxyHbN48
 rtf2H/U7dXe4skkspNNkJ0TeJYw1z2onohH8Tt46ZGsVB6a5Rrex41dbmGikjbESASwd3BkZD
 L98QMK5AI8Ydb497ldXRIJg8r1IxmjzXls099RB6gL2Nbx8UZjKIPZ4f6VdVjxUEHWHJT+FHY
 Ft4EX7eZ5n25/yW0ig7GNHnna8mZf5x/VFPTXgj/TxM83yWT6SIvGh9ZoWCFTTAhvrbyLe4iq
 qz4agA/UpHuMzc7/Z2IA40BxNF/pNUKWthU3eV2R4CrBNjcGWJOKhGQbuZRxTX8IposjfHWbF
 45x0x7npY79jxeOGdtPpircJTZn6GeuTDbJgDaMtJyFyKzsdEmxNecPgQashFSHEtZaADhjT0
 XgaDKhK55YlC0sWNpO+Wn84WpCU31NTlErZGXU2TGEhJzqKD7g679fPBHXrj6TAGFPpfW9rPI
 Ed1/oMZR6wocaq5ZnIkAzbFaG9MwbkuNjS6C8daXmdqZ9Bd/+fFGC87Gm32D1YIY/yPm5ov+X
 0st4xEs7pnVBOYbyM9ZPjQ82R6sNiBhVMyze74XRAe4k79fE/TWMoL33isWAXcWz87jPTRjYo
 Hh529fZhkO2knuku0SoLY+eRX/xVZWS4VP/+Pi22Iy8g0/QQZNjw6kYetUgn/jM0T+GlS4tRq
 TFek6RM8HsiSMsWK1csCYZy1oxbUre7MHvyO0h/2JSrs86apmZ9Y1JGLiz3j8J8QHFXKaDtxs
 +XlB4H2nGrjh6ubHkKxzGHp/0tXu1rzUwFZK79G6rlDkEy07VTum6PJ+ZuIzi8H0YvIg0Gk
X-Spam-Status: No, score=-97.9 required=5.0 tests=BAYES_00,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 19 May 2020 09:48:34 -0000

On May 13 15:40, Mark Geisert wrote:
> I'm not absolutely sure yet but I think this patch set isn't complete.
> What's been posted is OK for discussion (on cygwin-developers?) but would
> need to be augmented if you're going to apply as-is.
> 
> I had a git commit/revert mishap and these are recovered file versions.  I
> belatedly discovered there's no record in the patches of my creating
> directory winsup/cygwin/tzcode or of my deleting localtime.cc and
> tz_posixrules.h from winsup/cygwin in my local repository.
> 
> When it becomes time to submit the final patch versions, I'll do so from a
> brand new repository.  Sorry for any confusion.

Patchset discussions should stay on cygwin-patches as part of the set.

Please resend the patchset in the current state on top of current git.
Please add a cover letter (git format-patch --cover-letter ...) and just
start the discussion yourself in the cover letter.  Note what you
think is missing from the patchset and what you think needs addition or
change, so we're vaguely on the same level as you :)


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
