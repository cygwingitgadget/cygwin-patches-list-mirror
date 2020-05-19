Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id B59EC389201F
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 09:43:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B59EC389201F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N1PPJ-1iuFEu2Wxn-012qgB for <cygwin-patches@cygwin.com>; Tue, 19 May 2020
 11:43:47 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 09BBFA80F7E; Tue, 19 May 2020 11:43:47 +0200 (CEST)
Date: Tue, 19 May 2020 11:43:47 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] cygwin: doc: Add keywords for ACE order issues
Message-ID: <20200519094347.GP3947@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3749ce9f7c2eaeee1f600c4e8bede070f332bb69.camel@redhat.com>
 <20200513173402.00004eda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200513173402.00004eda@gmail.com>
X-Provags-ID: V03:K1:WP9CLWTL1bRSJNSJDdhBOHF3qQdKx+9EaOEjERSZhHczWr6dM2+
 Vw6napv7gP6+fQ1k2WiMdKHrwDNkqmB1tb1A7tLNlSgODdgRpTcw5Ls/LdkwC9tgizyNFPI
 mDEoCbOzuHOGi+Kn/+vzt3XDGCeDZIl7I0QJpFPfvkDsccHw01WFJ/3qZ3h8C6yFd5jb6Y0
 m9W/OBLFwvO6CP2F2VgCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a3Evz9sIh88=:4OUzt6XVBj8qmvCWK+zy6l
 p1v1frYLfKxp9I2xKR34IdXiOM7swClrsGWhJFuY+q6AqOCnyuiy9X+hWWLeVDDXyKGpB2jxV
 6EUxi1z0sa4Gm8JtW0Up3pe1koCpceP9X5nnqW68L8zz5cG2r5/pVhn7EybDwN5h37picazPV
 m4mA2+4gnXvhFRNVcLGBIBZiJVnCnqK9RjoH76bJqHcXsEtODuBeqUsOcXe/glwPk0mLoaz/t
 4sybEiw8stWoGwuvSVqtQapzyOqYp14zh/Tcu5DGPAAmIQoefrnmwrF3WWsACLhuzpOl82PEh
 oHBHU/qvQGdItEiNtkPN0DMRFkegwPDMxSPx+KplOI/JIMB8J7TkkSCHw4mI1gZAKl7+F/2xu
 zwBVq5DnJwW41YijIBr38BMq3/+rRLb+XchpwJGqWjQRaVGI5b3p1RNcttgdLGIp6ZLMtavsb
 KVdM/8Wr9CP7wiV9vdPWjuSJV10LyyZRPZ3saw77HbveFOwoCD1YmijM0xpZAFl79H7Dtoiy1
 HpkBM4ZLrftNB2FgHEN1/CsZa+6zOGluQZpl5oiFh6K2K7PzxB4j0XNwzAOVxVjY5ZXuF3Cek
 jbXeTA1b/5f9JuPiKbY2Dl2ALb8I6vJC4b1c0HZTJYX5mcuHc/itT/LgvRMsTobR1R+l5ZqPB
 +vHJkatWT2Nmyskmc7fHXd8xQK5Nz8gVOjkzcbNWQ0+cqC2XsHzZ8pGOtPYdusz8qFaQEB709
 5a/crRy4GuYc2nwjw/ZzqLbzB/yxcSCkKffrLM87sKNYiGXvcaOS1eBIxk/1DHt7xXftgqm4F
 1b+yml9Bj6m/6jV4J183qLxkbekZQLvWWsw+FDK6pfeUNPT3YnzessogxqoXHZ2WKRqtmn7
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
X-List-Received-Date: Tue, 19 May 2020 09:43:50 -0000

On May 13 17:34, David Macek via Cygwin-patches wrote:
> Windows Explorer shows a warning with Cygwin-created DACLs, but putting
> the text of the warning into Google doesn't lead to the relevant Cygwin
> docs.  Let's copy the warning text into the docs in the hopes of helping
> confused users.  Most of the credit for the wording belongs to Yaakov
> Selkowitz.
> 
> Latest inquiry: <https://cygwin.com/pipermail/cygwin/2020-May/244814.html>
> 
> Signed-off-by: David Macek <david.macek.0@gmail.com>
> ---

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
