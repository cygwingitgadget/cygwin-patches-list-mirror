Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id C68F0384402F
 for <cygwin-patches@cygwin.com>; Fri,  3 Jul 2020 19:34:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C68F0384402F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1McYTD-1jEWrg1hzZ-00cxeb for <cygwin-patches@cygwin.com>; Fri, 03 Jul 2020
 21:34:37 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CCEB9A8078C; Fri,  3 Jul 2020 21:34:36 +0200 (CEST)
Date: Fri, 3 Jul 2020 21:34:36 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 8/8] Cygwin: Consider DLL rebasing when computing dumper
 exclusions
Message-ID: <20200703193436.GC3499@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
 <20200701212529.13998-9-jon.turney@dronecode.org.uk>
 <20200702074317.GM3499@calimero.vinschen.de>
 <20200702074857.GP3499@calimero.vinschen.de>
 <9b0e3ddf-2fdd-990a-00f4-22939e21fa2b@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b0e3ddf-2fdd-990a-00f4-22939e21fa2b@dronecode.org.uk>
X-Provags-ID: V03:K1:yQJ2lNHzUMKPElODkHK9RjjEiHaGuBHPOamdao9/SwAzsSyjL5+
 UtqoPAh1EV4RKiysmue4jTtDKRH9/4+9iSHf2Br2B6/62KY44xzW09QlxnwNwMRTlvvojOp
 OmjkI9P745tFlo8LdV3fb+RJRPOhnDNMhCOXaGWfIABT1mx3/OwSGmGbT+i3/AtVNRQ1bh3
 XvoU6GjzDmDUOLvmNHRIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pyv6CLIuJ/Q=:K4VTCwjWpya/aBB7m5VPhl
 u4bRj/KLan6UJcc+toHyRXKa7S/veG/vkhl57UNrLEPI//otfhLT0YFK0KNg/575Fgi6HLnMw
 8z4llq1jrSVbuyEJfJIFc7wwRyyucSzLgUUOcnvnwEH7zfA+sZjwBdDi76RGEsfs0JPqgmZkp
 vsxqVlbIp1y7ZokgJ7pslT+e36gNoICnv9oCOz0xlt5VyRzQpK37bUtd2aGk+dnbsNdflszIh
 n98vBgh46VZaPtf5HhZsBsLdphDJbTBK4UKuakBLsBVgbUTLBCR8zSL3X9WwIHaphFU5qi3JT
 JDWgGKb5l95q17v3JR37DIvaEQ2/tnvSHFdxS/FxnVskK2Yp1BJBoxcAWoFGMNAp1y7wj4m8/
 LFYfzrMjBRpI2rvXUyXgIDlU0NF1smdBC1L55/2tLKY5CXaWWelNH+xA46HVLvfxGz7cvgRtK
 gHhAJGZprpRh7xD/DftBDfU+9TGo4N5eGWVwTP3y2ejOwj+uhaLWp73gy7UdiouaTNNCONPrf
 sY7i9XP1e2vjot6hXRhpI8+Ti0kqqpH/FgZUxZT10NDB69FsScZCI+N6bdt6YUfIsJefd1sxR
 cc02fwNxpAYOzAfph2B0CP0NO+QNS3dpBIRA16knV8n3ol4TJxrpsCvtIn0eclD4X7Gqek/xB
 /yeCr1hdM6I2WTd7pqPZSoFCS6lSTxxwGZYgInsJw/vQIFyQOirKeqwmqQeda3T7dXX8cu/Kp
 rAvJUMKXiTFzs6mRGxRtKRmMZCJgKFfGy4dN78af4Cvke03/NKCNdi4ve+iIEjVXt2FQ33Aa6
 sdDhKDBOuYJRU2S0PhjaFzTwE3WNh5yW+UXvQ2074GeTy9pUJY56eEhz3fAaZUn+e7N2j7Nou
 XpHsr4kHQMkiK/dCrIsw==
X-Spam-Status: No, score=-98.7 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Fri, 03 Jul 2020 19:34:41 -0000

On Jul  3 14:10, Jon Turney wrote:
> On 02/07/2020 08:48, Corinna Vinschen wrote:
> > On Jul  2 09:43, Corinna Vinschen wrote:
> > > On Jul  1 22:25, Jon Turney wrote:
> > > > I think this would always have been neeeded, but is essential on x86_64,
> > > > as kernel32.dll has an ImageBase of 00000001:80000000 (but is always
> > > 
> > > Great, but that shouldn't matter much given that system DLLs are
> > > ASLRed all the time.
> > > 
> > > > +parse_pe (const char *file_name, exclusion * excl_list, LPVOID base_address)
> > > >   {
> > > >     if (file_name == NULL || excl_list == NULL)
> > > >       return 0;
> > > > @@ -104,7 +104,19 @@ parse_pe (const char *file_name, exclusion * excl_list)
> > > >       }
> > > >     bfd_check_format (abfd, bfd_object);
> > > > -  bfd_map_over_sections (abfd, &select_data_section, (PTR) excl_list);
> > > > +
> > > > +  /* Compute the relocation offset for this DLL.  Unfortunately, we have to
> > > > +     guess at ImageBase (one page before vma of first section), since bfd
> > > > +     doesn't let us get at backend-private data */
> > > > +  bfd_vma imagebase = abfd->sections->vma - 0x1000;
> > > 
> > > VirtualQueryEx?  The AllocationBase is identical to the base address
> > > of the DLL loaded at that address.
> > 
> > Uhm... right.  Always assuming you get at the Windows process handle
> > from bfd...
> 
> The problem is in the opposite direction.
> 
> We have the actual base address the DLL was loaded at in the process being
> dumped, and it's filename, from the LOAD_DLL_DEBUG_EVENT event.
> 
> (To my amazement) we then read that DLL using bfd, and examine it for
> sections with the 'CODE' or 'DEBUGGING' flags, the address ranges
> corresponding to which we believe we want to exclude from the dump.
> 
> Unfortunately, these addresses are based on the ImageBase in the PE header.
> 
> If that's different to the actual base address the PE was loaded at, we need
> to adjust these addresses appropriately.  But libbfd doesn't appear to
> provide a public interface to get at the ImageBase.

Ok, but you have the filename, so you can map the file and read it's
header and thus imagebase.  Still not nice, sure... but it would work
without guessing, I guess? :)


Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
