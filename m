Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 1ED4A3857011
 for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2020 23:04:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1ED4A3857011
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id u24GjSKpOYYpxu24IjEN0r; Fri, 10 Jul 2020 17:04:34 -0600
X-Authority-Analysis: v=2.3 cv=OubUNx3t c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=VAVI7avi-4p2PNOo0hMA:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] pkg_upload.cygpart __pkg_announce SMTP HELO fails without
 smtp server FQDN
Date: Fri, 10 Jul 2020 17:04:31 -0600
Message-Id: <20200710230432.57869-2-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710230432.57869-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20200710230432.57869-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfItEaejQ/DI4Tm0q875UML4xnuuu1OWmHlz9k57Ag+sF6+dYK5GjhVJNRZYEZrKtqOA2mT0mqa1BIv0abr+kxExaosner1kGsz44dg4pAP7S0cHlrDBE
 K1dP97xmXAolqorbi0Zow3l8WRUpZkculjkZnYANxz4ZsGnDzoow1qOl57bAYyVB6bGBBPdjxYdZVSJOM6s1UglSKpVZogSd2T/S9R6f1grghhLkUoyer2nu
 DwToyrruT2MMEM5rN2RlbQ==
X-Spam-Status: No, score=-14.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_BL, RCVD_IN_MSPIKE_L3, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Fri, 10 Jul 2020 23:04:36 -0000

added git send-email perl code for FQDN with hooks in perl script
---
 lib/pkg_upload.cygpart | 51 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/lib/pkg_upload.cygpart b/lib/pkg_upload.cygpart
index f88525d..06024b4 100644
--- a/lib/pkg_upload.cygpart
+++ b/lib/pkg_upload.cygpart
@@ -168,6 +168,7 @@ EOF
 	echo "Upload complete."
 }
 
+
 __pkg_announce() {
 	local msg=$(mktemp -t cygwin-announce-${PF}.XXXXXX)
 	local msgat=$(date +@%s)
@@ -198,7 +199,52 @@ _EOF
 
 	${EDITOR:-vi} $msg || error "Editor exited abormally, aborting annoucement"
 
+# FQDN from git send-email
+# Returns the local Fully Qualified Domain Name (FQDN) if available.
+#
+# Tightly configured MTAa require that a caller sends a real DNS
+# domain name that corresponds the IP address in the HELO/EHLO
+# handshake. This is used to verify the connection and prevent
+# spammers from trying to hide their identity. If the DNS and IP don't
+# match, the receiving MTA may deny the connection.
+#
+# Here is a deny example of Net::SMTP with the default "localhost.localdomain"
+#
+# Net::SMTP=GLOB(0x267ec28)>>> EHLO localhost.localdomain
+# Net::SMTP=GLOB(0x267ec28)<<< 550 EHLO argument does not match calling host
+#
+# This maildomain*() code is based on ideas in Perl library Test::Reporter
+# /usr/share/perl5/Test/Reporter/Mail/Util.pm ==> sub _maildomain ()
+
 	perl <(cat <<EOF
+sub valid_fqdn {
+	my \$domain = shift;
+	return defined \$domain && !(\$^O eq 'darwin' && \$domain =~ /\.local\$/) && \$domain =~ /\./;
+}
+sub maildomain_net {
+    use Net::Domain ();
+	my \$maildomain;
+	my \$domain = Net::Domain::domainname();
+	\$maildomain = \$domain if valid_fqdn(\$domain);
+	return \$maildomain;
+}
+sub maildomain_mta {
+	my \$maildomain;
+	for my \$host (qw(mailhost localhost)) {
+		my \$smtp = Net::SMTP->new(\$host);
+		if (defined \$smtp) {
+			my \$domain = \$smtp->domain;
+			\$smtp->quit;
+			\$maildomain = \$domain if valid_fqdn(\$domain);
+			last if \$maildomain;
+		}
+	}
+	return \$maildomain;
+}
+sub maildomain {
+	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
+}
+
 use strict;
 use MIME::Parser;
 use Net::SMTP;
@@ -214,7 +260,9 @@ my \$entity = \$parser->parse_open("$msg");
 
 print "Sending announcement of ${NAME}-${PVR} via \$smtp_server\n";
 
+my \$smtp_domain ||= maildomain();  # get FQDN and add Hello below
 my \$smtp = new Net::SMTP(\$smtp_server,
+			  Hello => \$smtp_domain,
 			  ${SMTP_SERVER_PORT+Port => ${SMTP_SERVER_PORT},}
 			  SSL => \$smtp_encryption eq 'ssl')
 	 or die "No mailserver at ".\$smtp_server;
@@ -224,7 +272,8 @@ if (\$smtp_encryption eq 'tls') {
 	\$smtp->response();
 	\$smtp->code == 220 or die "$server does not support STARTTLS";
 	\$smtp = Net::SMTP::SSL->start_SSL(\$smtp) or die "STARTTLS failed";
-	\$smtp->hello(\$smtp_server);
+	# Send EHLO again to receive fresh supported commands
+	\$smtp->hello(\$smtp_domain);
 }
 if (defined \$smtp_user) {
 	use Authen::SASL qw(Perl);
-- 
2.27.0

