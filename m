Return-Path: <cygwin-patches-return-9577-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 43480 invoked by alias); 27 Aug 2019 20:00:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 43434 invoked by uid 89); 27 Aug 2019 20:00:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*c:Windows-1252
X-HELO: NAM01-BN3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr740107.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) (40.107.74.107) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 27 Aug 2019 20:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=UdyVbIsd51T50Xi43ZREgmpIRw+R7V/rq6lJfuS5Smja4wWKVf4oU76165kw69QLFbKUMFVcJcs6e3S51s143EhX13t3YVQt4HdM/TpzS4HDNnb3C4Ev+x01qXFcIYxrhOA4OAerYzkZ1RWTnpBk21F5bz2AVj44SlNjq2Br3GhF3j4jNJcjH3ubSwMOZ5+OQVSu6fr+lCrimg7bWumticLDLQCqZ4/SkngOQvbmf7p6zIAWjc93akNl5y2HuEiBEjSHqtinmEyuVe6Cmsb+jPyUBwJwETsbpgAHbfDxPFViQNLE3SAaE/6eNUD7+HwpMORiegVcJcjXEqvMIU0GNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=8zSkEmaGb3iJWOiBr3YGc1cro3TNnJFOUPfcGUDiGS4=; b=MUXXcOmMJua0nw7Vgqqh66LH3jpRZtlu+5KERP0CQGrMRCdta941vn88zWQqelpKCFSqcKPAk9nKYn/FyWPDgVsZbSHgG0zaUpCcJrwpPeGcDhqJdY+umuXAHy+HEbGQBtJzX2D1toQsA1tn9mQQWRZ1i/gkilbKNC9gUTephECKzcbd0DqiCIrxs+yQCypdi9Z1bZUn95CfrYZNAVTFARnLCp3/SNO+o07nl6xym1fqgY6CPX9a9XSfwW1WATSdNGV4LzMxc6L4UikZ5/XjQFsPK4ZkTm7Wrx6rHW/nUN4bFBByN1qopmeub3ZC9qTqz7IbBo4D0kXYQbe6HqNFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=8zSkEmaGb3iJWOiBr3YGc1cro3TNnJFOUPfcGUDiGS4=; b=FH9pOBQQUYIgEqkWkCjp0liaLR7l9ZOtajCgWclm8QH3tMTNJ1Mi9XGdRB5fIo33vEU2Iw2V/GvDb7ReVh+a8ShWLZWAzihTFghQFy0aEaFn/iEcGMNg9des5l9c0/GukDozjVIj4mHZdXl8MSXyzGi1Y+QymqKX+f9k3I7PWIo=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5052.namprd04.prod.outlook.com (20.176.111.145) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.20; Tue, 27 Aug 2019 20:00:13 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019 20:00:13 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: get_posix_access: avoid negative subscript
Date: Tue, 27 Aug 2019 20:00:00 -0000
Message-ID: <3020fe3e-1f5f-f53a-88c2-3d929e7f95d5@cornell.edu>
References: <20190826174324.46043-1-kbrown@cornell.edu> <20190827081355.GS11632@calimero.vinschen.de>
In-Reply-To: <20190827081355.GS11632@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:7219;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <EC2ED62EE8DB7A4A8AEC62806E60416B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/sYZ77YolFWg3uqQYXmEQBfQ+DgIb3PsjEMAGmFzYMOD1bp0Er10uVHFm2NJo9fovGm0Mzi33EoMt8dyOdNOA==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00097.txt.bz2

On 8/27/2019 4:13 AM, Corinna Vinschen wrote:
> On Aug 26 17:43, Ken Brown wrote:
>> Don't refer to lacl[pos] unless we know that pos >=3D 0.
>=20
> I'm not sure this is entirely right.  Moving the assignment to
> class_perm/def_class_perm into the previous if makes sense, but the
> bools has_class_perm and has_def_class_perm should be set no matter
> what, to indicate that class perms had been specified.

I don't think has_class_perm should be set if class_perm isn't set; that wo=
uld=20
cause a problem at sec_acl.cc:1169.  For has_def_class_perm it doesn't seem=
 to=20
matter.  Unless I'm missing something, has_def_class_perm is not used when=
=20
new_style is true.

> Either way, does this solve a real-world problem?  If so, a pointer
> or a short description would be nice.

No, I just happened to notice it while studying the ACL code.

Ken
