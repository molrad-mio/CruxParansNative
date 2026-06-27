const jwt = require('jsonwebtoken');
const fs = require('fs');

const keyId = 'ZY77AGB256';
const issuerId = '34eeb5d1-c2c8-464b-ba19-e98e53782079';
const privateKey = fs.readFileSync('C:/Users/molra/OneDrive/Desktop/AuthKey_ZY77AGB256.p8', 'utf8');

const now = Math.floor(Date.now() / 1000);
const payload = {
    iss: issuerId,
    iat: now,
    exp: now + 20 * 60,
    aud: 'appstoreconnect-v1'
};

const token = jwt.sign(payload, privateKey, { algorithm: 'ES256', keyid: keyId });

async function getCertificates() {
    try {
        const response = await fetch('https://api.appstoreconnect.apple.com/v1/certificates?limit=200', {
            method: 'GET',
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });
        const data = await response.json();
        if (response.status !== 200) {
            console.error(data);
            return;
        }
        console.log("Total Certificates found:", data.data ? data.data.length : 0);
        if (data.data && data.data.length > 0) {
            data.data.forEach(cert => {
                console.log(`- ID: ${cert.id}, Type: ${cert.attributes.certificateType}, Name: ${cert.attributes.name}, Expiration: ${cert.attributes.expirationDate}`);
            });
        }
    } catch (error) {
        console.error("Error fetching certificates:", error);
    }
}

getCertificates();
