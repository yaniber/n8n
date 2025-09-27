import type { Logger } from '@n8n/backend-common';
import { mock } from 'jest-mock-extended';

export const mockLogger = (): Logger => {
	const scopedLogger = mock<Logger>();
	const logger = mock<Logger>();
	
	// Double conversion de type pour éviter les erreurs TypeScript
	logger.scoped = ((() => scopedLogger) as unknown) as typeof logger.scoped;

	return logger;
};

export * from './random';
export * as testDb from './test-db';
export * as testModules from './test-modules';
export * from './db/workflows';
export * from './db/projects';
export * from './mocking';
