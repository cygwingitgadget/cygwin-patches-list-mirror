Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id EEA9E3858002
 for <cygwin-patches@cygwin.com>; Thu, 22 Jul 2021 08:03:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org EEA9E3858002
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MEF87-1lySvO2Oqz-00AJFu for <cygwin-patches@cygwin.com>; Thu, 22 Jul 2021
 10:03:47 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E3867A80BC1; Thu, 22 Jul 2021 10:03:46 +0200 (CEST)
Date: Thu, 22 Jul 2021 10:03:46 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Add more winsymlinks values
Message-ID: <YPkmYgHpDLmsyJjI@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
 <YPfYgz0EHe7Yw5ko@calimero.vinschen.de>
 <616f5f9b-83e2-689c-bda3-dddc50dff5f0@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <616f5f9b-83e2-689c-bda3-dddc50dff5f0@t-online.de>
X-Provags-ID: V03:K1:qRkj0nEuirnRnW4fxa4fyFae9aKqR0JacAr8P5eKOLu4tvdEUN6
 QLark5spW6FtAPDXTAByNJa9kAs9y2/b4myLuW1SeD172qu33RdOJuNJeiNy/tBTUef45Sq
 MInmKKCKaBMQFn7QZ4aUTfdIFSVRdfrl0PxSUJxzjlzJHkdkwkR2uvSmjtNYRcqO3ewuRTw
 FBXLbAM5SNHcQIG+2tbTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:suse87TYWFA=:T9deQDkp6mgTGwZnSblG3D
 9xSozblLgumxGE10/ytXD9K+Yqt69ziws/DtmdVixasPIbSfZoJkS328RNdkyxs9zsjPPz128
 6+fERvVLpgWgQevd26ZjHYuPKzJxfDbzApDF4ErEo2Z7g5pHKckn9MoplSqEzlo/GhvLB5pOy
 95LyqrwT2M06yZgcgf4zgUgov2rYteOrmnmOlhb3WeF5WrVVAiN9/qGdndO40LLKTcTh2/nDU
 qA947JkGJnX6AWkj3nn5KW5TxvjUFXVv6j4q1wwa2Q+kiwkS6O7xzYPxyCMg/JOJLlYbijtyj
 MPbED9oFBco01HiHPyn7QRYK+TF5W4goXCM77kzVGFetbKlQOe6Kw4ZqZRe7eOuobCh9+0GST
 etgGg6YpH28qyQifI36Ytrkxc+htrElYgg4ob5UfQsNVBwUpQ1hmpFnZTpKZQA6jwFQ1CVuoh
 y9jjwk5pPNJv2EkRsbwMVfEVz6sWZsc+FblzXNhAi3TvG6FSn77++Z84YchV6mCbJUww3+EdV
 Xtkzp2Ot0ZB/ElTSfQYCCCr4sTAhPEwcuVZLVgFM3Jleas5i1SEuGBGVWuVTuZYf5aRnpP0hu
 nLAcF/j9i54moJjjCVaidFaoUru2/tHkKOEjhKEkpkBsgDoSULa3Vg+OUiVYJ/5VKa0KTKHoz
 M99hfE31KT1CHLELGbnfbzfbhu7YVJ7QWVgEToHLta4/peMmtELdRTnbuCeXySgt+gb1blkYj
 wQUk8lHg6h9pOIyhqicTEfrV3CY6fC4YocM7R+JL3C8zQtPsSszOHSdaUvn4Nt6+9RiD+2bfp
 shRbjL+E8Ao+ISO8WQ4ayzUfb9FTLVCUQPQI0eSTbfnhOQU+LsUKNyJtR59iFOPybWySS0y7q
 UCwtTE6gaftz/duHyaPA==
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL,
 SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Thu, 22 Jul 2021 08:03:56 -0000

On Jul 21 12:24, Christian Franke wrote:
> Corinna Vinschen wrote:
> > On Jul 19 17:31, Jon Turney wrote:
> > > I'm not sure this is the best idea, since it adds more configurations that
> > > aren't going to get tested often, but the idea is that this would enable
> > > proper and consistent control of the symlink type used from setup, as
> > > discussed in [1].
> > > 
> > > [1] https://cygwin.com/pipermail/cygwin-apps/2021-May/041327.html
> > Why isn't it sufficient to use 'winsymlinks:native' from setup?
> > 
> > The way we express symlinks shouldn't be a user choice, really.  The
> > winsymlinks thingy was only ever introduced in a desperate attempt to
> > improve access to symlinks from native tools, and I still don't see a
> > way around that.  But either way, what's the advantage in allowing the
> > user complete control over the type, even if the type is only useful in
> > Cygwin?
> > 
> 
> WSL compatible symlinks introduce several issues with non-Cygwin
> Copy/Archive/Backup tools (robocopy behaves strange, 7-Zip stores these as
> empty files, ...).

Native backup tools are supposed to store unknown reparse points
verbatim,  If they don't, it's a bug in these tools which not only
affects Cygwin, but every unknown reparse point.


Corinna
